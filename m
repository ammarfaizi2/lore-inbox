Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbSKIAmc>; Fri, 8 Nov 2002 19:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263332AbSKIAmc>; Fri, 8 Nov 2002 19:42:32 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:37317 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263321AbSKIAma>; Fri, 8 Nov 2002 19:42:30 -0500
Date: Fri, 8 Nov 2002 16:50:11 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Rusty Trivial Russell <trivial@rustcorp.com.au>,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] SCSI on non-ISA systems
Message-ID: <20021109005011.GC1040@beaverton.ibm.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Russell King <rmk@arm.linux.org.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Rusty Trivial Russell <trivial@rustcorp.com.au>,
	linux-scsi@vger.kernel.org
References: <20021108135742.A22790@flint.arm.linux.org.uk> <Pine.GSO.4.21.0211081522050.23267-100000@vervain.sonytel.be> <20021108144234.A24114@flint.arm.linux.org.uk> <1036772421.16651.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036772421.16651.10.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox [alan@lxorguk.ukuu.org.uk] wrote:
> On Fri, 2002-11-08 at 14:42, Russell King wrote:
> > Probably the correct answer is to get everyone to use an explicit release
> > function and just kill scsi_host_generic_release() entirely.
> > 
> > However, I'm sure other people will have differing views on that.
> 
> There are three things I'd like to do in that area
> 
> 1.	Make a release function mandatory (and I'm happy to paste it into the
> old scsi drivers)

This sounds good to get rid of this function. My list of drivers having
detect functions shows only 16 of 103 would need the addition of a
release function.

There is already a check for detect at the top of the scsi_register_host
function. When release is added a printk would also be nice to indicate
lack of these required functions. Douglas Gilbert is starting to work on
updating the api document so we can change the required field to yes if
the driver is using the scsi_register_host / scsi_unregister_host
interface and not-required if it using Christoph's newer scsi_add_host /
scsi_remove_host.

-andmike
--
Michael Anderson
andmike@us.ibm.com

