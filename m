Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280609AbRKBIvn>; Fri, 2 Nov 2001 03:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280608AbRKBIvd>; Fri, 2 Nov 2001 03:51:33 -0500
Received: from 112.ppp1-1.hob.worldonline.dk ([212.54.84.112]:30080 "EHLO
	milhouse.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S280603AbRKBIv0>; Fri, 2 Nov 2001 03:51:26 -0500
Date: Fri, 2 Nov 2001 09:51:15 +0100
From: Jens Axboe <axboe@suse.de>
To: Dan Podeanu <pdan@spiral.extreme.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi bug, or..?
Message-ID: <20011102095114.K607@suse.de>
In-Reply-To: <20011102082314.E607@suse.de> <Pine.LNX.4.33L2.0111021246490.1987-100000@spiral.extreme.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0111021246490.1987-100000@spiral.extreme.ro>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02 2001, Dan Podeanu wrote:
> > You are trying to mount /dev/hdc and that is handled by ide-scsi. Mount
> > /dev/sr0 instead. For that you must also remember to configure SCSI
> > CD-ROM support, which you haven't done:
> >
> > # CONFIG_BLK_DEV_SR is not set
> >
> 
> That config was after several attempts of getting a functional kernel in
> that aspect.

A failed attempt :-)

> With CONFIG_BLK_DEV_SR=y, the same result. Also note that mount/cat/etc.
> on hdc _should_ work, but it fails both there and on /dev/sg0, etc.

No it should not, not if you are passing control to ide-scsi. /dev/sg0
is the sg char device, you cannot mount that. Look at your messages:

ide-scsi: hdc: unsupported command in request queue (0)
end_request: I/O error, dev 16:01 (hdc), sector 64
isofs_read_super: bread failed, dev=16:01, iso_blknum=16, block=32
mount: wrong fs type, bad option, bad superblock on /dev/hdc1,

You are mounting major 16h (22, hdc), not /dev/scd0. This is a user
error, not a bug.

-- 
Jens Axboe

