Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbUCUJuZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 04:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbUCUJuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 04:50:24 -0500
Received: from mx2.elte.hu ([157.181.151.9]:22685 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263600AbUCUJuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 04:50:23 -0500
Date: Sun, 21 Mar 2004 10:51:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sched_setaffinity usability
Message-ID: <20040321095116.GA7721@elte.hu>
References: <40595842.5070708@redhat.com> <20040318112913.GA13981@elte.hu> <20040318120709.A27841@infradead.org> <Pine.LNX.4.58.0403180748070.24088@ppc970.osdl.org> <20040318182407.GA1287@elte.hu> <405AB72B.4030204@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405AB72B.4030204@aitel.hist.no>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Helge Hafting <helgehaf@aitel.hist.no> wrote:

> Let the compile create that info file.  Then handle it much like a
> module, except that it is a "module" without any code.  I.e. copy it
> to /lib/modules/<kernelversion> if installing modules, or stuff the
> file into the initrd if making an initrd. 
> 
> Now it is in a place specific to the kernel, where a library can find
> it.

this has a couple of disadvantages:

 - the kernel can pre-map the 'file' cheaper - in fact on x86 it's
   zero-cost currently. Mapping a file takes 3 syscalls and at least one
   pagefault. Since glibc needs a good portion of this info for
   absolutely every ELF binary, why not provide it in a preconstructed
   way? x86 is doing it via the VDSO. ia64 and x86-64 is doing it via a
   dso-alike mechanism.

 - obtaining the kernel version currently needs one more syscall
   [uname()].

 - the 'metadata' becomes detached from the kernel image, so it
   cannot contain 'crutial' data. Testing kernels becomes harder, etc.
   (until now i could just send a bzImage to someone to get it tested -
    now it would have to include the metadata too.)

 - it excludes non-build-time data.

	Ingo
