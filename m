Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbTLEKfj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 05:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263857AbTLEKfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 05:35:34 -0500
Received: from h-69-3-93-191.SNVACAID.dynamic.covad.net ([69.3.93.191]:47240
	"EHLO adam.yggdrasil.com") by vger.kernel.org with ESMTP
	id S263803AbTLEKfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 05:35:07 -0500
Date: Fri, 5 Dec 2003 03:35:02 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200312051135.hB5BZ2V06015@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I am not a lawyer, so please do not rely on what I say as
legal advice.

	Even for proprietary Linux kernel modules that do not contain
a byte of GPL'ed code, I see at least two levels of potential copyright
infringement.  I think the conversation has largely missed the second,
and more important case: contributory infringment, but I really have
to start with the direct infringement to explain clearly.

	The direct infringement occurs occurs when a user creates an
infringing work in RAM, which I think is restrictable for works that
are licensed rather than sold due to the US 9th circuit federal
appeals court decision MAI Systems Corp. v. Peak Computer [1]:

| [39] We have found no case which specifically holds that the copying of 
| software into RAM creates a "copy" under the Copyright Act. However, 
| it is generally accepted that the loading of software into a computer 
| constitutes the creation of a copy under the Copyright Act. See 
| e.g. Vault Corp. v. Quaid Software Ltd., 847 F.2d 255, 260 (5th 
| Cir. 1988) ("the act of loading a program from a medium of storage 
| into a computer's memory creates a copy of the program"); 2 Nimmer on 
| Copyright, § 8.08 at 8-105 (1983) ("Inputting a computer program 
| entails the preparation of a copy."); Final Report of the National 
| Commission on the New Technological Uses of Copyrighted Works, at 13 
| (1978) ("the placement of a work into a computer is the preparation of 
| a copy"). We recognize that these authorities are somewhat troubling 
| since they do not specify that a copy is created regardless of whether 
| the software is loaded into the RAM, the hard disk or the read only 
| memory ("ROM"). However, since we find that the copy created in the 
| RAM can be "perceived, reproduced, or otherwise communicated," we hold 
| that the loading of software into the RAM creates a copy under the 
| Copyright Act. 17 U.S.C. § 101. We affirm the district court's grant 
| of summary judgment as well as the permanent injunction as it relates 
| to this issue. 
[...]
| 5. Since MAI licensed its software, the Peak customers do
| not qualify as "owners" of the software and are not eligible for
| protection under § 117.
 
	I believe this standard was applied specifically to operating
systems by Triad Systems Corp. v. Southeastern Express [2].

	By the way, I believe the MAI decision was narrowed slightly
by the Digital Millennium Copyright Act[3], but only to allow third
party maintenance organizations to reboot computers that they maintain.

	These decisions apparently limit the copyright exception
originally recommended by the CONTU panel [4] for making it legal to
run copyrighted programs in RAM [5].

	Although I recnetly heard a copyright lawyer say that there
are a string of cases supporting the doctrine that copying to RAM is
restrictable by copyright, I should also point out that these are
cases that I turned up some time ago in a google search.  This may be
an example of how a little knowledge can be a dangerous thing.  I do
not, for example, know what legal references the Free Software
Foundation used to convince NeXT Computer that they had to release the
source code to their Objective C GCC object files.


	The second, more practically restrictable, potential form of
infringement is contributory infringement by those who distribute
proprietary kernel modules, such as authors, FTP site maintainers,
vendors, and their employees.  Even if proprietary Linux kernel module
is shipped as an object which has other uses besides being linked into
Linux, it invariably requires "glue" code to work in Linux.  _Even
when the "glue" code is open source_, if it's only substantial use is
to form part of an infringing work in RAM, then it is a contributory
infringement device.  Here is a diagram to help illustrate:

		 -----------------------------------
		| Core Linux kernel:		    |
		| Covered by GPL and other          |
		| compatible free software licenses |
		 -----------------------------------
				|
				|
				|
				|
		 -----------------------------------
                | Glue code:                        |
		| Perhaps released under	    |
		| GPL-compatible license, but still |
	        | contributory infringement to      |
	        | distribute, because it has no     |
		| substantial non-infringing use.   |
		 -----------------------------------
				|
				|
				|
				|
		 -----------------------------------
		| Proprietary object: perhaps used  |
		| in drivers for other OS's too.    |
                | May have substantial              |
                | non-infringing use, and be legal  |
		| to distribute, but still direct   |
		| copyright infringement by end user|
		| to load into kernel.              |
		 -----------------------------------


	The glue code may be part of the proprietary module or may be
distributed as a separate middle layer module.  This code usually has
no "substantial non-infringing use", thereby failing the test
established for contributory copyright infringement from the 1984 US
Supreme court decision, Sony Corporation of America v. Universal City
Studios, Inc. [6], which basically set the common law test for
contributory copyright infringement to be the same as the statutory
standard for contributory patent infringement [7].

	Granted, it may be possible to write multi-purpose
GPL-compatible glue code, every byte of which has a substantial
non-infringing use.  For those cases, distribution might not be
restrictable, but it would still be copyright infringement by the end
user to load the module into a running Linux kernel.

	I am not claiming that these are the only possible legal
problems or potential copyright problems with proprietary kernel
modules.  There are other possible infringement scenarios, such as
direct infringement in proprietary source code that is comingled with
GPL'ed source code, or direct infringement in object code that
contains some GPL'ed inline routines.  Kernels running with
proprietary modules also might not be covered by the "free for GPL'ed
use" patent grants [8, 9, 10].

	I must reiterate, however, that I am not a lawyer.  So, please
do not rely on what I say as legal advice.  The most consequential
action that anyone should take based on this message is to ask a
lawyer about it.


[1] MAI Systems Corp. v. Peak Ccomputer, Inc., 991 F.2d 511 (1993).
    http://www.law.cornell.edu/copyright/cases/991_F2d_511.htm

[2] Triad Systems v. Southeastern Express, 64 F.3d 1330 (1995).
    http://www.eff.org/IP/triad_v_southeastern_64f3d1330_decision.html

[3] The Digital Millenium Copyright Act of 1998.
    www.loc.gov/copyright/legislation/dmca.pdf

[4] United States Code, Title 17 (Copyright), Section 117,
    (Limitation on exclusive rights: computer programs)
    http://www.bitlaw.com/source/17usc/117.html

[5] Final Report of the National Commission on New Technology Uses
    [CONTU] of Copyrighted Works, chapter 3:
    http://digital-law-online.info/CONTU/contu6.html

[6] Sony Corporation of America v. Universal City Studios, Inc.
    ("the betamax decision")
    http://www.eff.org/Legal/Cases/sony_v_universal_decision.html

[7] For "substantial noninfringing use", see United States Code, Title 35
    (Patents) Section 271 (Infringement of Patent), paragraphs (c) and (f)(2).
    http://www.bitlaw.com/source/35usc/271.html

[8] "Yodaiken clarifies the Open RTLinux Patent License"
    http://linuxdevices.com/articles/AT6164867514.html

[9] "The RTLinux Open Patent License, version 2.0"
    http://www.fsmlabs.com/products/rtlinuxpro/rtlinux_patent.html

[10] "GPL patent grant for 19 patents"
     http://www.advogato.org/article/89.html


Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
