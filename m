Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132982AbRAFUEi>; Sat, 6 Jan 2001 15:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132981AbRAFUE2>; Sat, 6 Jan 2001 15:04:28 -0500
Received: from tamqfl1-ar1-128-154.dsl.gtei.net ([4.33.128.154]:65526 "EHLO
	linus.southpark") by vger.kernel.org with ESMTP id <S132041AbRAFUEY>;
	Sat, 6 Jan 2001 15:04:24 -0500
Message-ID: <3A577A51.74C5E0F4@leoninedev.com>
Date: Sat, 06 Jan 2001 15:04:33 -0500
From: Bryan Mayland <bmayland@leoninedev.com>
Organization: Leonine Development, Inc.
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: -=da TRoXX=- <TRoXX@LiquidXTC.nl>
Subject: Re: Framebuffer as a module
In-Reply-To: <E14EZMf-0007vp-00@the-village.bc.nu> <y7rk889wk6o.fsf@sytry.doc.ic.ac.uk> <3A5755D6.5607D908@leoninedev.com> <002501c07819$21343900$fd1942c3@bluescreen>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-=da TRoXX=- wrote:

> and i don't get it, who accepts these parameters in the kernel then? i mean
> if i put them in lilo.conf at least SOME thing uses them to set the
> framebuffer right...

    The tdfxfb code does.  When compiled into the kernel, there is a function
(tdfxfb_setup) which the kernel calls with the relevant kernel command-line
parameters.  When compiled as a module, this function is ifdef'ed out, as well
it should be, because I don't think that there is a function which is called to
pass the module parameters.  Modules use MODULE_PARM to 'import' their
parameters.  The code is incomplete, perhaps for a reason.  In theory, the
author should add the required MODULE_PARM macros to export the parameters and
then move the code which does anything besides saving the paramter values to
tdfxfb_init, which is called when the module is loaded /and/ after tdfxfb_setup
when compiled into the kernel.  I don't have the time to fix it myself, I don't
even have a machine with Linux and a Voodoo3 card.

> I know this parameter is for modules only that support modedb (modedb.c) but
> tdfxfb supports that(that's why it works in the kernel)...

    It does, but only when compiled into the kernel due to the way it does its's
setup.

Bry

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
