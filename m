Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268854AbUIZK3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268854AbUIZK3t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 06:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268861AbUIZK3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 06:29:49 -0400
Received: from hera.cwi.nl ([192.16.191.8]:11915 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S268854AbUIZK3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 06:29:47 -0400
Date: Sun, 26 Sep 2004 12:29:37 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: micah milano <micaho@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: SiI3112 Serial ATA Maxtor 6Y120M0 incorrect geometry detected
Message-ID: <20040926102937.GA27269@apps.cwi.nl>
References: <70fda320409251214129bba57@mail.gmail.com> <70fda3204092514037c6dc039@mail.gmail.com> <58cb370e04092515157e9b72ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e04092515157e9b72ef@mail.gmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2004 at 12:15:33AM +0200, Bartlomiej Zolnierkiewicz wrote:

> I'm tired of this issue and this is what I'm going to do:
> - remove CHS info from IDE printks and /proc/ide/
> - add BLKGETSTART ioctl for getting partition's start sector
>   (this is the only legitimate use of HDIO_GETGEO currently)
> - at least obsolete HDIO_GETGEO in IDE or even remove it (failing is
>   better than returning unexpected results)
> - silence complainers :)
> 
> Bartlomiej

Yes. Consider returning 0 for C/H/S in HDIO_GETGEO.

We need the BLKGETSTART ioctl for another reason:
the field start of a struct hd_geometry has 32 bits
and fails for partitions starting past the 2TB mark.
So, just like BLKGETSIZE64, this BLKGETSTART must
return a u64 and return an offset in bytes.

As we all know, geometry is meaningless for IDE.
But it is not for MFM/RLL and similar ancient stuff.
If support for old disks is not broken yet, try not to break it.

Andries
