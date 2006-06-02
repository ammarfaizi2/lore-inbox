Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWFBApc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWFBApc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 20:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWFBApc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 20:45:32 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:53895 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750997AbWFBApb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 20:45:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WOROjKczMzoH4wn1p7sYUFwpFI5FB9qtF0YryNvCtCvZfZnE9sNQaHxSotLO257LhUoR1Sx1XGUmUeEFV6stYDCyzb7+oXoIBbCCfMz5QmIoRt7R2u6ViAbWQqtwfv9qUeKg5Jmxka8TR2HJQXVMFj8wKbl9k2E1qEar1w823W0=
Message-ID: <9e4733910606011745n7277ca57vf8d32dfed9da2c4e@mail.gmail.com>
Date: Thu, 1 Jun 2006 20:45:20 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Dave Airlie" <airlied@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "D. Hazelton" <dhazelton@enter.net>,
       "David Lang" <dlang@digitalinsight.com>,
       "Ondrej Zajicek" <santiago@mail.cz>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
In-Reply-To: <21d7e9970606011647l11a780d3h816fee2cc01e72a9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com>
	 <Pine.LNX.4.63.0606010758380.3827@qynat.qvtvafvgr.pbz>
	 <200606011603.57421.dhazelton@enter.net>
	 <9e4733910606011335q5791997drc02d23f398a2acf5@mail.gmail.com>
	 <21d7e9970606011614x5b4d3a3t9608971a714f8c77@mail.gmail.com>
	 <9e4733910606011638s587fff33lbfe46f6a2817245b@mail.gmail.com>
	 <21d7e9970606011647l11a780d3h816fee2cc01e72a9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/06, Dave Airlie <airlied@gmail.com> wrote:
> We can stop the OOM killer from killing the daemon if necessary.
> running device drivers in userspace would sort of require this, we can
> run the daemon from init and if it dies, have it respawn, it could put
> persistent info in a shared memory segment provided by the DRM, just
> because you can't think of any way around things, doesn't mean the
> rest of us can't..
>
> a /dev/ with permissions is no more or less useful than a
> /tmp/.grphs_socket1 and 2
> with permissions,

/dev/devices have a standard system design in the kernel with h files
and ioctls. Why create a new communication protocol when a standard
one exists? How is a printk generated in the kernel going to find this
socket and get the printk message into it?

You have a panic in an interrupt handler. User space is messed up
because of wild pointer writes in the kernel. Your display process has
been swapped out. How are you going to display the panic message?

How does a process protected from the OOM killer that is also pinned
into memory differ from just being part of the kernel? Is creating a
process like this and building a communication system worth it just to
get address space separation?

Why don't you write up a comprehensive design for your system and post
it for all to read. It is difficult to piece together an overall
picture from 100s of emails talking about specific features. To do
this right  you have to address everything from fbdev to X to SDL to
i8n. There were 13 design requirements posted earlier, can your system
satisfy all of those?

Any designs you propose have to be able to stand up to questioning
like this. It is much better to deal with the problems as questions
rather than to find them after the code is written.

-- 
Jon Smirl
jonsmirl@gmail.com
