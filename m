Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUBDR6Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 12:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbUBDR6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 12:58:24 -0500
Received: from odpn1.odpn.net ([212.40.96.53]:10903 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id S261774AbUBDR6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 12:58:14 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Gabor Z. Papp" <gzp@papp.hu>
Subject: Re: Linux 2.4.25-pre7 - no DRQ after issuing WRITE
Date: Wed, 4 Feb 2004 16:52:58 +0100
User-Agent: KMail/1.5.3
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <Pine.LNX.4.58L.0401231652020.19820@logos.cnet> <200402021700.50301.bzolnier@elka.pw.edu.pl>
 <x68yjiq2vr@gzp>
In-Reply-To: <x68yjiq2vr@gzp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402041652.58980.bzolnier@elka.pw.edu.pl>
X-Authenticated: odpn1 gzp1.gzp.hu e31ad0d0a9cedc9f056b4904cfffac56
X-Spam-Checked-By: gzp1.gzp.hu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 of February 2004 16:29, Gabor Z. Papp wrote:
> * Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>:
> | Dunno :-).  I use smartmontools and non-Linux vendor tools
> | (ie. from www.seagate.com) to make sure that drive is okay.
> | If these tests pass and drive works with other OS-es then
> | I suspect bug in IDE core or in specific IDE chipset driver.
>
> Downloaded the seagate seatools, and ran the full tests.
>
> The diagnostic tool told me I have to send back the disk...
>
> DST - Errors - Status: 07
> Short Test Failed: [date]
>
> BAD Sector LBA: 125249531
> Unable to resolve sector usage.
>
> [lot of such errors for various sectors]
>
> Scan Completed... PROBLEMS FOUND.
>
> So, "no DRQ after issuing WRITE" is due these drive errors?

Yes, when DMA write fails (ie. because of a bad sector), driver disables
DMA and tries to retry transfer in PIO mode but obviously that fails too
(drive doesn't "ack" PIO write command and thus this message).



