Return-Path: <linux-kernel-owner+w=401wt.eu-S932650AbWLNMTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbWLNMTL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 07:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932688AbWLNMTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 07:19:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41436 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650AbWLNMTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 07:19:10 -0500
Subject: Re: Executability of the stack
From: Arjan van de Ven <arjan@infradead.org>
To: Franck Pommereau <pommereau@univ-paris12.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45813E67.80709@univ-paris12.fr>
References: <458118BB.5050308@univ-paris12.fr>
	 <1166090244.27217.978.camel@laptopd505.fenrus.org>
	 <45813E67.80709@univ-paris12.fr>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 14 Dec 2006 13:19:07 +0100
Message-Id: <1166098747.27217.1018.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-14 at 13:07 +0100, Franck Pommereau wrote:
> >> # grep maps /proc/self/maps
> >> bfce8000-bfcfe000 rw-p bfce8000 00:00 0          [stack]
> > 
> > this shows that the *intent* is to have it non-executable. 
> > Not all x86 processors can enforce this. All modern ones do.
> 
> Mine is quite recent:

> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm

the "nx" shows that if you configure your kernel correctly (enable PAE)
that you indeed have a non-executable capability, which will apply to
the stack (and afaik the heap too)

> > the alternative (showing effective permission) is equally confusing;
> > apps would see permissions they didn't set...
> 
> Indeed, both are confusing (the other way is having permission that you
> do not see). But which one is the most dangerous from a security point
> of view? For me it is believing that you're protected while you're not.

it's debatable what the file means; the maps file shows software
permissions currently not hardware enforced permissions. The "problem"
is that if you show software permissions... it's harder to see the
kernels view (vma's etc). I don't think there's a perfect answer.

It gets even more complex if you have something like execshield in use;
where the stack and heap are non-executable, unless you get a "higher"
executable mapping. In that case, the appearance of such a higher
mapping would change the visual mapping of other mappings. Outright
confusing as well :)
> 
> >> Maybe it comes from sharing source code for 64 bits and 32 bits
> >> architectures but if so, it should be possible (and highly desirable) to
> >> treat 32 bits differently.
> > 
> > it's not a "32 bit" thing, it's an "older processors don't, newer ones
> > do" thing.
> 
> I've read that 64 bit processors have an execute bit at the page level
> while 32 bit ones do not (only at the segment level). I didn't know that
> newer 31 bit CPUs did have this bit.

your cpu has this bit, you just didn't turn it on ;(

> > Can you paste your /proc/cpuinfo file here ? Maybe you have a processor
> > with the capability but just haven't enabled it (either in the bios or
> > in the kernel config)
> 
> I'd be happy to know how to enable it.

enable
CONFIG_HIGHMEM64G=y

and you're all set.


Greetings,
   Arjan van de Ven

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

