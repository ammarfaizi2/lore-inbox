Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263197AbUCTBsu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 20:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbUCTBsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 20:48:50 -0500
Received: from mail.convergence.de ([212.84.236.4]:18645 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263197AbUCTBst
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 20:48:49 -0500
Date: Sat, 20 Mar 2004 02:48:37 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] barrier patch set
Message-ID: <20040320014837.GB11865@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Matthias Andree <matthias.andree@gmx.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040319153554.GC2933@suse.de> <405B2127.8090705@pobox.com> <20040319230136.GC7161@merlin.emma.line.org> <200403200102.39716.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403200102.39716.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Saturday 20 of March 2004 00:01, Matthias Andree wrote:
> >
> > BTW, speaking of identify-device, hdparm -i (which uses
> > HDIO_GET_IDENTITY) always returns "WriteCache=enabled" while hdparm -I
> > that uses HDIO_DRIVE_CMD with WIN_PIDENTIFY reports the "correct" state
> > that I've previously set with -W0. This is an i386 machine w/ 2.6.5-rc1.
> >
> > Is HDIO_GET_IDENTITY working correctly?
> 
> There were reports that on some drives you can't disable write cache
> and even (?) that some drives lie (WC still enabled but marked as disabled).

hdparm -i and -I ultimately both interpret WIN_IDENTIFY result, and both test
bit 0x0020 of word 85. So it's unclear to me why they report a
different write cache setting. I added a hexdump to dump_identity()
in hdparm.c, and found that bit 0x0020 of word 85 is always set.

BTW, 'cat /proc/ide/hda/identify' or 'hdparm -Istdin </dev/ide/hda/identify'
reports the same value as hdparm -I, and that is consistent with
the value I set with hdparm -W x.


So, is HDIO_GET_IDENTITY broken?

Johannes
