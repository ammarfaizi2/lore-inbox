Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131743AbRCUTO1>; Wed, 21 Mar 2001 14:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131733AbRCUTOS>; Wed, 21 Mar 2001 14:14:18 -0500
Received: from stat8.steeleye.com ([63.113.59.41]:47369 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131724AbRCUTOE>; Wed, 21 Mar 2001 14:14:04 -0500
Message-Id: <200103211913.OAA02121@localhost.localdomain>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Kurt Garloff <garloff@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: SMP on assym. x86
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 21 Mar 2001 14:13:15 -0500
From: James Bottomley <James.Bottomley@SteelEye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> recently upgrading one of my two CPUs, I found kernel-2.4.2 to be
> unable to handle the situation with 2 different CPUs (AMP =3D
> Assymmetric multiprocessing ;-) correctly. Some details on my system:
> Dual BX board (DFI P2XBL/D), iPII 350 (Deschutes) + iPIII 850
> (Coppermine) Note: The difference in features is the XMM (SSE) flag.

> The problems are twofold (a) Determination of the correct common
> features (=3D: COMCAP), i.e.
>     boot_cpu_data.x86_capaility[0] at the correct time (b) TSC stuff

I have similar problems.  I've got a reconfigurable non-APIC 8 way system with 
(currently) 4 p5-66 and 4 p5-166 processors.  I found the answer to (b) was 
simply to disable the TSC stuff---my processors aren't even guaranteed to be 
fed from the same clock, so there's no hope for TSC coherency.

I run into your problem (a) when trying a mixture of 486 and 586 processors.  
The simplest work around I find is just to make sure that the boot CPU has the 
lowest capability set (i.e. boot off a 486).  Could you just swap the order of 
your processors to achieve the same effect?

James Bottomley


