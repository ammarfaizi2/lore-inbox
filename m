Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWEaArr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWEaArr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 20:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbWEaArr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 20:47:47 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:26254 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932479AbWEaArq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 20:47:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GbsTAobyz6EHfclOwiWtS/KrJ9wr2l85cwseE8l4EtyMzVj1/JyB0TmtCQG0+eOJxWzvmapvyAvhRxQ3q9aQNrXBjuhyGdaYILSDOBxzqd26iV3BtQ3WxO4RFc/JukTulwbG/jmyrZuJUR6aBfMOpMaaMZIVvxYUZ/KvyFw32r8=
Message-ID: <9e4733910605301747x13e1271atf5aecf335eee61c5@mail.gmail.com>
Date: Tue, 30 May 2006 20:47:36 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Pavel Machek" <pavel@ucw.cz>, "Dave Airlie" <airlied@gmail.com>,
       "D. Hazelton" <dhazelton@enter.net>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <447CDCB7.8080708@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200605280112.01639.dhazelton@enter.net>
	 <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com>
	 <20060529124840.GD746@elf.ucw.cz>
	 <21d7e9970605291623k3636f7hcc12028cad5e962b@mail.gmail.com>
	 <20060530202401.GC16106@elf.ucw.cz>
	 <9e4733910605301356k64dcd75fo38e45e1b7572817f@mail.gmail.com>
	 <21d7e9970605301601t37f8d3ddwaf4a900ed8997fdf@mail.gmail.com>
	 <9e4733910605301627t2f28db08vf58c78e2656b7047@mail.gmail.com>
	 <20060530233826.GE16106@elf.ucw.cz> <447CDCB7.8080708@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > Actually, vbetool is the piece of puzzle we currently use to
> > reinitialize graphics cards after resume. (suspend.sf.net).
>
> But vbetool can only handle primary cards, can't it?

That is correct, but you can get the ROM image for all adapters out of
sysfs now so it is not really hard to change it.  Handling secondary
cards is another feature of the new tools that isn't finished yet.

The tool should also put the image back into the kernel after the ROM
is run. A lot of these ROM assume they are running out of shadow RAM
and make changes to the image.

> > We currently do it all in userspace; it would be cleaner to do it as
> > call_usermodehelper() from kernel.
>
> I had a patch sometime before, vm86d.  It's a daemon in userspace that
> accepts requests from the kernel which executes x86 instructions using
> lrmi, then pushes the result back to the kernel.  I modified vesafb
> so that it uses this daemon which makes vesafb acquire the capability
> to do on the fly mode switching (similar in functionality with
> vesafb-tng which uses a different method).
>
> I abandoned this patch, but it seems there's might be at least one user.
>
> spblinux (http://spblinux.sourceforge.net/)

This is very similar to what I am proposing. I would just spawn the
app off each time instead of using a daemon; it's not like you are
changing mode every few seconds. By spawning each time you can avoid
the problem of the kernel trying to figure out if the daemon has died.

-- 
Jon Smirl
jonsmirl@gmail.com
