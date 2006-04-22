Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWDVBLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWDVBLu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 21:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWDVBLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 21:11:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:41424 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750830AbWDVBLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 21:11:49 -0400
From: Andi Kleen <ak@suse.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: Linux 2.6.17-rc2
Date: Sat, 22 Apr 2006 03:07:17 +0200
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       meissner@suse.de
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org> <200604220002.16824.ak@suse.de> <200604220153.44984.s0348365@sms.ed.ac.uk>
In-Reply-To: <200604220153.44984.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604220307.17383.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 April 2006 02:53, Alistair John Strachan wrote:

> > > Alistair, if you can do a "git bisect" on this one, that would help.
> >
> > If noexec32=off doesn't help please do.
> > If noexec32 helps then it's likely a wine bug for using the wrong
> > protections.
> 
> [alistair] 01:52 [~] uname -rm
> 2.6.17-rc2 x86_64
> 
> [alistair] 01:52 [~] cat /proc/cmdline
> vga=794 root=/dev/sda1 quiet noexec32=off
> 
> [alistair] 01:51 [~/.wine/drive_c/Program Files/Warcraft III] wine 
> war3.exe -opengl
> err:ole:CoCreateInstance apartment not initialised
> fixme:advapi:SetSecurityInfo stub
> 
> Aaand wine suddenly starts working again.

Ok. There is a way to change this at runtime for individual 
processes too (using personality), but most distros seem 
to miss the user tools for that so far.

> Looks like a bug in WINE; is there  
> any additional information required before I can file a bug report on this 
> one? Thanks.

They probably forget to set PROT_EXEC in either mprotect or mmap somewhere.
You can check in /proc/*/maps which mapping contains the address it is faulting
on and then try to find where it is allocated or mprotect'ed.

-Andi
