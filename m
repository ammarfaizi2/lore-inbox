Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285636AbRLGXHw>; Fri, 7 Dec 2001 18:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285637AbRLGXHm>; Fri, 7 Dec 2001 18:07:42 -0500
Received: from codepoet.org ([166.70.14.212]:19207 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S285636AbRLGXHf>;
	Fri, 7 Dec 2001 18:07:35 -0500
Date: Fri, 7 Dec 2001 16:07:34 -0700
From: Erik Andersen <andersen@codepoet.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: On re-working the major/minor system
Message-ID: <20011207160734.A18800@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3C10A057.BD8E1252@evision-ventures.com> <E16CJnv-0005c0-00@the-village.bc.nu> <20011207135100.A17683@codepoet.org> <9urbtm$69e$1@cesium.transmeta.com> <20011207145535.A18152@codepoet.org> <3C113CFA.5090109@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C113CFA.5090109@zytor.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: 2.4.13-ac8-rmk1, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Dec 07, 2001 at 02:04:42PM -0800, H. Peter Anvin wrote:
> 
> It's clear a painful change is needed.  **We don't have a choice.**
> However, the fewer places we have to make source code changes the better.

Sure.  I'm not arguing again the change.  Just making sure
everyone 100% understands that we have just thown any prayer of
binary compatibility with anything less then 2.5.x....

But lets look on the bright side though.  Since we are going to
be having a flag day _anyways_ we may as well make the most of
it.  I can think of 20 things off the top of my head that are
being retained in the name of binary cmpatibilty that can easily
move to the trash bucket.  :)

For example, I would _love_ for Linux to standardize syscall
numbers across all architectures, guarantee that userspace gets
the exact same stack setup for all arches, we might as well fixup
proc, etc, etc, etc.


> What we agreed upon when this was discussed last year was the following:
> 
> dev_t is extended to a 12:20 (32-bit size.)  I personally would rather
> have seen a 64-bit size (32:32) but was outvoted :(
> 
> New major 0 is reserved, except that dev_t == 0 remains the code for "no
> device".  The unnamed device major becomes major 256.
> 
> If (dev_t & ~0xFFFF) == 0, the dev_t is interpreted as an old-format
> dev_t, and is interpreted according to the following algorithm:
> 
> 	if ( dev && (dev & ~0xFFFF) == 0 ) {
> 		major = (dev >> 8) ? (dev >> 8) : 256;
> 		minor = dev & 0xFF;
> 	} else {
> 		major = dev >> 20;
> 		minor = dev & 0xFFFFF;
> 	}

That works, and should prevent most major problems.  Hmm.  At
least for cpio there are 6 chars worth of device info in there,
so we coule easily go to 48 bits without RPM problems.  Or redhat
could fix rpm to use tarballs like debs do, and then we could go
to 64 bit devices no problem.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
