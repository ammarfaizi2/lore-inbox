Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWGKPVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWGKPVv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWGKPVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:21:51 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:12500 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751287AbWGKPVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:21:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=CVHNu1gCLcAcs9Vu4EI+x9DjmkWqitemAy9JKFabFgrgsa3VYKHvlhi6kizoDbbcaDQ6v1YhTVCydPImv7JpzH2MG9C/5ZQoj6wDGE0UmwCX91NGuhLoJWMHUm7gtLzwoHDncu5RvrT5HY24A5uxndk/Hllen76SO9npjfqd0OM=
Message-ID: <44B3C203.2010202@gmail.com>
Date: Tue, 11 Jul 2006 23:21:39 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, rdunlap@xenotime.net, mreuther@umich.edu,
       linux-kernel@vger.kernel.org, zap@homelink.ru
Subject: Re: [PATCH] fbdev: Statically link the framebuffer notification functions
References: <200607100833.00461.mreuther@umich.edu>	 <44B34D68.3080602@gmail.com> <20060711032817.94c78ae0.akpm@osdl.org>	 <44B39D4D.8060209@gmail.com>	 <9e4733910607110621i720db936sebdd0bcb60fab4ad@mail.gmail.com>	 <44B3AA51.1040003@gmail.com>	 <9e4733910607110646m7f95581cl52669daddf5f2fa1@mail.gmail.com>	 <44B3B6ED.9020705@gmail.com>	 <9e4733910607110743w29573c02h981324a110adba11@mail.gmail.com>	 <44B3BACF.4000305@gmail.com> <9e4733910607110803me340cbdg52b91933a6a2bbfe@mail.gmail.com>
In-Reply-To: <9e4733910607110803me340cbdg52b91933a6a2bbfe@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 7/11/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> > The code looks ok but this sure smells like inter_module_*.
>>
>> I assure you, there is no smell of inter_module_* here. What scenario
>> are you afraid of?
> 
> Dangling references during the load/unload process. That was
> inter_module's problem.

That won't happen. If fbdev unloads, then the module that does the
notification disappears, and the clients won't receive notifications.
If the client is the one that unloads first, it unregisters its notifier
block, and that's one less client for fbdev to notify (And fbdev doesn't
know how many clients are there, that's internal to the notifier). And
since registration, unregistration and the call to the callout function
in the notifier block are protected by a semaphore (in the blocking type),
the danger of unregistration while in the midst of a notification is
removed.

Tony
