Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWGKPDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWGKPDy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWGKPDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:03:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:63690 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750970AbWGKPDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:03:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XXB1/Z1QQU/NXRKztyhst5OXvcXsRlnq0LmkcGvGavDj94d/x+HOBZbUWjhw2yB50ePFU0cMmwoUhMCspzt1bysVCqzjEx5YzWTHfh06kAmAmNcsOErGbn8U23VDu1b8DvoJvYux/2/G0v/qkqRQWxA4vlfacxz/qvrhaG86tlo=
Message-ID: <9e4733910607110803me340cbdg52b91933a6a2bbfe@mail.gmail.com>
Date: Tue, 11 Jul 2006 11:03:52 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] fbdev: Statically link the framebuffer notification functions
Cc: "Andrew Morton" <akpm@osdl.org>, rdunlap@xenotime.net, mreuther@umich.edu,
       linux-kernel@vger.kernel.org, zap@homelink.ru
In-Reply-To: <44B3BACF.4000305@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607100833.00461.mreuther@umich.edu>
	 <44B34D68.3080602@gmail.com> <20060711032817.94c78ae0.akpm@osdl.org>
	 <44B39D4D.8060209@gmail.com>
	 <9e4733910607110621i720db936sebdd0bcb60fab4ad@mail.gmail.com>
	 <44B3AA51.1040003@gmail.com>
	 <9e4733910607110646m7f95581cl52669daddf5f2fa1@mail.gmail.com>
	 <44B3B6ED.9020705@gmail.com>
	 <9e4733910607110743w29573c02h981324a110adba11@mail.gmail.com>
	 <44B3BACF.4000305@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > The code looks ok but this sure smells like inter_module_*.
>
> I assure you, there is no smell of inter_module_* here. What scenario
> are you afraid of?

Dangling references during the load/unload process. That was
inter_module's problem.

>
> > I guess
> > inter_module had to deal with arbitrary users and this code is dealing
> > with a fixed set of clients which makes it more manageable.
> >
> > Have you considered making this a generic service and not fb specific?
> >
>
> It's basically a wrapper to the notifier_call_chain, that's as generic
> as it can get. And yes, it's not fb_specific (meaning, there's no need
> for the client module to know fbdev internals), that's why the lcd and
> backlight subsystem can take advantage of it.

The generic code could create notifier chains with a name. The modules
would then use the name to attach. Now you don't need the fb_notifier
code.

-- 
Jon Smirl
jonsmirl@gmail.com
