Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265241AbUFUAk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265241AbUFUAk2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 20:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265543AbUFUAk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 20:40:28 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:24457
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S265241AbUFUAk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 20:40:26 -0400
From: Rob Landley <rob@landley.net>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Using kernel headers that are not for the running kernel
Date: Sun, 20 Jun 2004 19:37:20 -0500
User-Agent: KMail/1.5.4
Cc: Nick Bartos <spam99@2thebatcave.com>, linux-kernel@vger.kernel.org
References: <53712.192.168.1.12.1087514884.squirrel@192.168.1.12> <200406190546.50166.rob@landley.net> <20040620162405.GA16038@havoc.gtf.org>
In-Reply-To: <20040620162405.GA16038@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406201937.20057.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 June 2004 11:24, Jeff Garzik wrote:

> Kernel-internal headers and definitions should absolutely never be used
> in userspace.

Hence the old #ifdef KERNEL stuff, or whatever the guard was...

My only confusion was that when the #ifdefs stopped being maintained (written 
off as inherently unworkable because people just #defined KERNEL when they 
shouldn't), no actual replacement was pursued.  Instead the attitude seemed 
to be "this is glibc's problem", we're too busy trying to get 2.6 out to 
actually worry about anybody using it.  And calling it glibc's problem 
doesn't work for me, because want to use uclibc...

> H. Peter Anvin has suggested an include/abi which could be shared, and
> this seem quite reasonable to me.  However, the monumental task of
> separating kernel-internal definitions from ABI definitions still
> remains.
>
> 	Jeff, really glad the linux-libc-headers guys started his effort

Mazur seems to be doing a really nice job of it so far.  I'm building a small 
distro based on it and sending him bug reports when I can't get something to 
compile.  I'm happy to use his work, but I'd rather it got integrated into 
the kernel.

Now that it's mostly stabilized, it seems that the remaining work is mostly 
auditing, integrating it in under the include/abi directory, and cleaning up 
the normal kernel headers to include the abi stuff rather than defining their 
own copies in the kernel internal headers.

If an abi directory was created, I'd be happy to submit a file or two at a 
time into it (with the corresponding patches to remove the definitions from 
the main include directory and #include abi/whatever instead...)

(Is there some effort _other_ than Mazur's work I should know about?  Or 
something wrong with Mazur's cleanups?  Or somebody already doing this...?)

Rob
-- 
www.linucon.org: Linux Expo and Science Fiction Convention
October 8-10, 2004 in Austin Texas.  (I'm the con chair.)

