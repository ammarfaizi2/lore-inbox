Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290779AbSAYSwT>; Fri, 25 Jan 2002 13:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290787AbSAYSwB>; Fri, 25 Jan 2002 13:52:01 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:54473 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S290786AbSAYSvz>;
	Fri, 25 Jan 2002 13:51:55 -0500
Message-Id: <m16UBRc-000OVeC@amadeus.home.nl>
Date: Fri, 25 Jan 2002 18:51:24 +0000 (GMT)
From: arjan@fenrus.demon.nl
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: [PATCH]: Fix MTRR handling on HT CPUs (improved)
cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16UBUl-0003J9-00@the-village.bc.nu>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E16UBUl-0003J9-00@the-village.bc.nu> you wrote:
> As Dave pointed out I was mixing them

>> just not do it on the right CPU (you're _not_ supposed to read to see if
>> you are writing the same value: MTRR's can at least in theory have
>> side-effects, so it's not the same check as for the microcode update).

> So why not just set it twice - surely that is harmless ? Why add complex
> code ?

mtrr code does

"read value" -> store in variable
"set uncached"
<do lots of fiddling>
"write stored value"

on all cpus precisely in parallel.

Now... on HT the second half will store the value the first half just set to
uncached. and worse: it will RESTORE that into the final mtrr..

