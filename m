Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbTH0UjO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 16:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTH0UjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 16:39:14 -0400
Received: from codepoet.org ([166.70.99.138]:8354 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S262151AbTH0UjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 16:39:13 -0400
Date: Wed, 27 Aug 2003 14:39:13 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Backport recent IDE updates, take 2
Message-ID: <20030827203913.GA1699@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Andries Brouwer <aebr@win.tue.nl>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030817061225.GA17621@codepoet.org> <20030822221109.GB3802@codepoet.org> <1061998505.22721.54.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061998505.22721.54.camel@dhcp23.swansea.linux.org.uk>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 27, 2003 at 04:35:07PM +0100, Alan Cox wrote:
> On Gwe, 2003-08-22 at 23:11, Erik Andersen wrote:
> > CHS), and sanely clamps LBA48 when not doing DMA, preventing data
> > corruption, and avoids idedisk_supports_host_protected_area()
> 
> Doesnt seem to do that right. Marcelo, please don't apply any of this
> stuff until someone actually fixes the lba48 clipping properly

        if (idedisk_supports_lba48(id)) {
                /* drive speaks 48-bit LBA */
                drive->select.b.lba = 1;
                drive->capacity64 = id->lba_capacity_2;
                if (hpa)
                        idedisk_check_hpa(drive);
                if (drive->addressing == 0 && drive->capacity64 > (1ULL)<<28) {
                        /* FIXME:  most controllers that won't do LBA48 with
                         * DMA will do it via PIO so we ought to implement a
                         * PIO fallback...   For now, punt and limit the drive
                         * to 128 GiB to prevent bad things from happening... */
                        drive->capacity64 = (1ULL)<<28;
                }
	}

This is not sufficient?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
