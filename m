Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262476AbTCIIao>; Sun, 9 Mar 2003 03:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262478AbTCIIao>; Sun, 9 Mar 2003 03:30:44 -0500
Received: from hera.cwi.nl ([192.16.191.8]:19442 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262476AbTCIIao>;
	Sun, 9 Mar 2003 03:30:44 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 9 Mar 2003 09:41:21 +0100 (MET)
Message-Id: <UTC200303090841.h298fLm26761.aeb@smtp.cwi.nl>
To: aebr@win.tue.nl, alan@lxorguk.ukuu.org.uk
Subject: Re: ide-problem still with 2.4.21-pre5-ac1
Cc: Andries.Brouwer@cwi.nl, Harald.Schaefer@gls-germany.com,
       Thomas.Mieslinger@gls-germany.com, davidsen@tmr.com,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> why its not honouring PTBL values in his case apparently

The disk capacity code foolishly sets heads to 255, and then
ide_xlate_1024 decides that we already have chosen a translation,
so that it does not have to figure out what translation to use.

Andries

See:
        if (xparm == 2) {
                if (!heads ||
                   (drive->bios_head >= heads && drive->bios_sect == 63))
                        transl = 0;
        }
        if (xparm == -1) {
                if (drive->bios_head > 16)
                        transl = 0;     /* we already have a translation */
        }
