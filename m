Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbSKHPue>; Fri, 8 Nov 2002 10:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbSKHPud>; Fri, 8 Nov 2002 10:50:33 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:1180 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262208AbSKHPua>; Fri, 8 Nov 2002 10:50:30 -0500
Subject: Re: [PATCH] SCSI on non-ISA systems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Rusty Trivial Russell <trivial@rustcorp.com.au>
In-Reply-To: <20021108144234.A24114@flint.arm.linux.org.uk>
References: <20021108135742.A22790@flint.arm.linux.org.uk>
	<Pine.GSO.4.21.0211081522050.23267-100000@vervain.sonytel.be> 
	<20021108144234.A24114@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Nov 2002 16:20:21 +0000
Message-Id: <1036772421.16651.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-08 at 14:42, Russell King wrote:
> Probably the correct answer is to get everyone to use an explicit release
> function and just kill scsi_host_generic_release() entirely.
> 
> However, I'm sure other people will have differing views on that.

There are three things I'd like to do in that area

1.	Make a release function mandatory (and I'm happy to paste it into the
old scsi drivers)

2.	Call eh_abort/eh_reset_* without taking the lock as we do now

3.	Make all the midlayer callers use scatter gather lists for all
	requests.

#1 and #3 are I think doable for 2.6, #2 is a bit more questionable.
(#3 is easy because drivers supporting the old non sg case still work
just fine)

