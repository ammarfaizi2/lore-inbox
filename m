Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276369AbRJURZJ>; Sun, 21 Oct 2001 13:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276384AbRJURY7>; Sun, 21 Oct 2001 13:24:59 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:14880 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S276397AbRJURYk>; Sun, 21 Oct 2001 13:24:40 -0400
Date: Sun, 21 Oct 2001 20:25:02 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Joerg Schilling <schilling@fokus.gmd.de>
Cc: cdwrite@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10ac10, cdrecord 1.9-6, Mitsumi CR-4804TE: lock up burning too large image
Message-ID: <20011021202502.D1598@niksula.cs.hut.fi>
In-Reply-To: <200110211210.f9LCAIl08971@burner.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110211210.f9LCAIl08971@burner.fokus.gmd.de>; from schilling@fokus.gmd.de on Sun, Oct 21, 2001 at 02:10:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2001 at 02:10:18PM +0200, you [Joerg Schilling] claimed:
> 
> >Ok. I'll compile the newest from source.
> 
> >But do you think the too-large-image lock up might be cured with a newer
> >cdrecord, or should is the kernel the prime suspect?
> 
> It least recent libscg versions include a workaround for an incorrect
> Linux kernel return for a timed out SCSI command via ATAPI. So if the kernel 
> does return at all, cdrecord will know why.

Bummer. I'm not able to reproduce it with

progress -c 1M < /dev/zero | cdrecord dev=0,1,0 speed=4 -dummy -
(essentially same as 'cdrecord dev=0,1,0 speed=4 -dummy - < /dev/zero')

(The line I originally used was "cdrecord dev=0,1,0 speed=4 -" and the input
was from mkisofs.)

cdrecord-1.9-6

  686.00 MB; elapsed 1172 secs; 0.59 MB/s...
  cdrecord: Input/output error. write_g1: scsi sendcmd: retryable error
  CDB:  2A 00 00 05 53 E1 00 00 1F 00
  status: 0x0 (GOOD STATUS)
  write track data: error after 715065344 bytes
  Sense Bytes: 70 00 00 00 00 00 00 0A 00 00 00 00 00 00 00 00 00 00

and cdrecord 1.11a08

  686.00 MB; elapsed 1172 secs; 0.59 MB/s...
  ./cdrecord: Input/output error. write_g1: scsi sendcmd: no error
  CDB:  2A 00 00 05 53 E1 00 00 1F 00
  status: 0x2 (CHECK CONDITION)
  Sense Bytes: 71 00 03 00 00 00 00 0A 00 00 00 00 0C 00 00 00
  Sense Key: 0x3 Medium Error, deferred error, Segment 0
  Sense Code: 0x0C Qual 0x00 (write error) Fru 0x0
  Sense flags: Blk 0 (not valid)
  cmd finished after 5.706s timeout 40s
  write track data: error after 715065344 bytes
  Sense Bytes: 70 00 00 00 00 00 00 0A 00 00 00 00 00 00 00 00 00 00

(nothing in dmesg.)

Perhaps it really takes real write to trigger this or the cd media in
question was somehow flawed. I try again, when I have more time.


-- v --

v@iki.fi
