Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbTIMLEg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 07:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbTIMLEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 07:04:36 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:62179 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262128AbTIMLEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 07:04:34 -0400
Date: Sat, 13 Sep 2003 13:04:32 +0200 (MEST)
Message-Id: <200309131104.h8DB4WqV021726@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: bunk@fs.tum.de
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Cc: alan@lxorguk.ukuu.org.uk, davej@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Sep 2003 00:51:39 +0200, Adrian Bunk <bunk@fs.tum.de> wrote:
>> > > - Which CPUs exactly need X86_ALIGNMENT_16?
>> >
>> >Unsure. This could use testing on a few systems.
>> 
>> K7s and P5s (and 486s too if I remember correctly) strongly prefer
>> code entry points and loop labels to be 16-byte aligned. This is
>> due to the way code is fetched from L1.
>>...
>
>Hm, that's pretty different from the definition in -test5:
>
>config X86_ALIGNMENT_16
>        bool
>        depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || 
>          MELAN || MK6 || M586MMX || M586TSC || M586 || M486 || MVIAC3_2
>        default y

My comment referred to data from Intel and AMD code optimisation
guides.

The kernel only uses X86_ALIGNMENT_16 to derive two __ALIGN macros
for assembly code, but it doesn't use them except in one place in
the pnpbios code.

gcc -march=<cpu type> should generate appropriate alignment for
function entries and loop labels.

I suspect X86_ALIGNMENT_16 is a left-over from old code.
Perhaps its time to retire it.

/Mikael
