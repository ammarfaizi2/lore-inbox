Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWEaBXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWEaBXo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 21:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbWEaBXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 21:23:44 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:24334 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751511AbWEaBXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 21:23:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=afdAevy7b5xcUtHEbb7LKF4MNH4oHhG1AzKFI2b4U2GPs09xil1zT1FDt0q9z8e99kZbgdZS2JgQeiut29lB5x7vEC4EyAivnl+E4zj1x9kShFOrW0Z6jwY2sZSvORje3Ya65hEkAwdtm1MyalNO5a5LzxsDldRcqvfizVkaXcY=
Message-ID: <447CF007.5070904@gmail.com>
Date: Wed, 31 May 2006 09:23:19 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Pavel Machek <pavel@ucw.cz>, Dave Airlie <airlied@gmail.com>,
       "D. Hazelton" <dhazelton@enter.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <200605280112.01639.dhazelton@enter.net>	 <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com>	 <20060529124840.GD746@elf.ucw.cz>	 <21d7e9970605291623k3636f7hcc12028cad5e962b@mail.gmail.com>	 <20060530202401.GC16106@elf.ucw.cz>	 <9e4733910605301356k64dcd75fo38e45e1b7572817f@mail.gmail.com>	 <21d7e9970605301601t37f8d3ddwaf4a900ed8997fdf@mail.gmail.com>	 <9e4733910605301627t2f28db08vf58c78e2656b7047@mail.gmail.com>	 <20060530233826.GE16106@elf.ucw.cz> <447CDCB7.8080708@gmail.com> <9e4733910605301747x13e1271atf5aecf335eee61c5@mail.gmail.com>
In-Reply-To: <9e4733910605301747x13e1271atf5aecf335eee61c5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 5/30/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> > Actually, vbetool is the piece of puzzle we currently use to
>> > reinitialize graphics cards after resume. (suspend.sf.net).
>>
>>
>> I had a patch sometime before, vm86d.  It's a daemon in userspace that
>> accepts requests from the kernel which executes x86 instructions using
>> lrmi, then pushes the result back to the kernel.  I modified vesafb
>> so that it uses this daemon which makes vesafb acquire the capability
>> to do on the fly mode switching (similar in functionality with
>> vesafb-tng which uses a different method).
>>
>> I abandoned this patch, but it seems there's might be at least one user.
>>
>> spblinux (http://spblinux.sourceforge.net/)
> 
> This is very similar to what I am proposing. I would just spawn the
> app off each time instead of using a daemon; it's not like you are
> changing mode every few seconds. By spawning each time you can avoid
> the problem of the kernel trying to figure out if the daemon has died.

I was thinking of reviving this patch, because of problems with suspend/
resume and mode setting. But if there is a plan to put an emulator as part
of the kernel library, I'll hold off.

I'm also thinking of using a different user-kernel interface.  The old
patch creates a misc device which the daemon opens, but can the kernel
connector do the job? I don't know anything about this.

Tony

PS: This user helper need not just do x86 calls, it might use OF or even
X. (I believe the Xen people have something similar). A userspace
framebuffer driver usable by the kernel console is definitely possible.

