Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWDVAxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWDVAxo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 20:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWDVAxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 20:53:44 -0400
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:28432 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1750801AbWDVAxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 20:53:44 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Andi Kleen <ak@suse.de>
Subject: Re: Linux 2.6.17-rc2
Date: Sat, 22 Apr 2006 01:53:44 +0100
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org> <Pine.LNX.4.64.0604210932020.3701@g5.osdl.org> <200604220002.16824.ak@suse.de>
In-Reply-To: <200604220002.16824.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604220153.44984.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 April 2006 23:02, Andi Kleen wrote:
> On Friday 21 April 2006 18:40, Linus Torvalds wrote:
> > On Fri, 21 Apr 2006, Alistair John Strachan wrote:
> > > Something in here (or -rc1, I didn't test that) broke WINE. x86-64
> > > kernel, 32bit WINE, works fine on 2.6.16.7. I'll check whether -rc1 had
> > > the same problem and work backwards, but just in case somebody has an
> > > idea..
> >
> > Nothing strikes me, but maybe Andi has a clue.
>
> NX for 32bit programs is enabled by default now. Does it
> work with noexec32=off?
>
> If it's that then it won't work with PAE kernels on i386 and NX
> capable machines neither - i just changed the default to be
> the same as 32bit, but unlike 32bit all x86-64 kernels use PAE
> and many of the systems have NX.
>
> If it's not that  don't know what it could be. I actually even used a
> simple wine program with a post rc2 kernel and it worked for me.
>
> So it isn't anything fundamental. Maybe some bad interaction
> with copy protection again, but I don't remember changing ptrace
> at all this time.
>
> > Alistair, if you can do a "git bisect" on this one, that would help.
>
> If noexec32=off doesn't help please do.
> If noexec32 helps then it's likely a wine bug for using the wrong
> protections.

[alistair] 01:52 [~] uname -rm
2.6.17-rc2 x86_64

[alistair] 01:52 [~] cat /proc/cmdline
vga=794 root=/dev/sda1 quiet noexec32=off

[alistair] 01:51 [~/.wine/drive_c/Program Files/Warcraft III] wine 
war3.exe -opengl
err:ole:CoCreateInstance apartment not initialised
fixme:advapi:SetSecurityInfo stub

Aaand wine suddenly starts working again. Looks like a bug in WINE; is there 
any additional information required before I can file a bug report on this 
one? Thanks.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
