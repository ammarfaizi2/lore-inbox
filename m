Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVBOSUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVBOSUF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 13:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVBOSUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 13:20:04 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:36808 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261627AbVBOSTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 13:19:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=j8eqnR3gAKdikI8lER8m/Wh5rApCv1DRb790ZDT1RLQTdiW8QKr2RoWg3tuAdOiXSgrfRH1iPRMGAOKXw0JWnnINJFq3bxtYPV5gmtWkEbeKfV91sqmnbVsbrSyVp7oAmwfb1M4nOHj1zj8Askv8fg7KG2NhS1ciP3lo4rkcMJ4=
Message-ID: <29495f1d05021510195cd561cd@mail.gmail.com>
Date: Tue, 15 Feb 2005 10:19:48 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC UPDATE PATCH] add wait_event_*_lock() functions and comments
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, Sergey Vlasov <vsu@altlinux.ru>,
       Al Borchers <alborchers@steinerpoint.com>, david-b@pacbell.net,
       greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <200502151850.46217.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1108105628.420c599cf3558@my.visi.com>
	 <29495f1d05021221003ef31c3e@mail.gmail.com>
	 <20050215010435.GD2403@us.ibm.com> <200502151850.46217.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2005 18:50:45 +0100, Arnd Bergmann <arnd@arndb.de> wrote:
> On Dinsdag 15 Februar 2005 02:04, Nishanth Aravamudan wrote:
> > Here's at least one example:
> >
> > drivers/ieee1394/video1394.c:__video1394_ioctl()
> >
> AFAICS, that one should work just fine using after converting

<snip>

> The trick here is that it is known in advance that the state does not actually
> have to be protected by the lock after reading it, because the state can not
> change from READY to FREE in any other place in the code.
> One exception might be two processes calling the ioctl at the same time, but
> I think that is racy will any of these variations.

Hmm, I think you might be right, actually. So, for now, I guess it is
ok to not have these macros globally available (I may end up changing
my mind as I go through trying to replace other
interruptible_sleep_on() callers, but I'll cross that bridge when I
get to it :)

Thanks,
Nish
