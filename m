Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129833AbRB0USX>; Tue, 27 Feb 2001 15:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129837AbRB0USN>; Tue, 27 Feb 2001 15:18:13 -0500
Received: from atlrel2.hp.com ([156.153.255.202]:63177 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S129833AbRB0USC>;
	Tue, 27 Feb 2001 15:18:02 -0500
Message-ID: <3A9BEF68.72EEF0E8@fc.hp.com>
Date: Tue, 27 Feb 2001 13:18:16 -0500
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Camm Maguire <camm@enhanced.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 IDE tape problem, with ide-scsi
In-Reply-To: <54u25g3yb9.fsf_-_@intech19.enhanced.com> <3A9BC2A9.F5EE8554@fc.hp.com> <544rxg2gde.fsf@intech19.enhanced.com> <3A9BC8ED.698DCA2C@fc.hp.com> <54vgpvq4y1.fsf@intech19.enhanced.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Camm Maguire wrote:
> 
> Greetings!  OK, with st debugging, here are the most common errors
> with the Conner:
> 
> Feb 27 14:46:39 intech9 kernel: st0: Error: 28000000, cmd: 8 1 0 0 40 0 Len: 16
> Feb 27 14:46:39 intech9 kernel: Info fld=0x24, Current st09:00: sns = f0  8
> Feb 27 14:46:39 intech9 kernel: ASC=14 ASCQ= 3
> Feb 27 14:46:39 intech9 kernel: Raw sense data:0xf0 0x00 0x08 0x00 0x00 0x00 0x24 0x0a 0x00 0x00 0x00 0x00 0x14 0x03 0x00 0x00
> Feb 27 14:46:39 intech9 kernel: st0: Sense: f0  0  8  0  0  0 24  a
> Feb 27 14:46:39 intech9 kernel: st0: Tape error while reading.

This was a read command that failed. Request sense information shows a
sense key of 0x08 which is a "Blank check". This sense key indicates
either a blank medium found or another error at EOD. ASC/ASCQ of
0x14/0x03 say "End-Of-Data not found". This indicates something wrong
with the tape or maybe the drive needs cleaning. Do you get this error
with more than one tape?


> Feb 27 14:46:40 intech9 kernel: st0: Error: 28000000, cmd: 5 0 0 0 0 0 Len: 16
> Feb 27 14:46:40 intech9 kernel: [valid=0] Info fld=0x0, Current st09:00: sns = 70  5
> Feb 27 14:46:40 intech9 kernel: ASC=20 ASCQ= 0
> Feb 27 14:46:40 intech9 kernel: Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x20 0x00 0x00 0x00
> Feb 27 14:46:40 intech9 kernel: st0: Can't read block limits.

This was a "Read Block Limits" command which the drive claimed it does
not recognize. "Read Block Limits" is a mandatory command for SCSI
sequential access devices which is why "st" is issuing this command. The
tape drive you have is not SCSI, so the manufacturer chose not to
implement this command. The driver may still be able to work after "Read
Block Limits" fails, but I have not read enough code to be sure.

> Feb 27 14:46:40 intech9 kernel: st0: Mode sense. Length 11, medium b6, WBS 10, BLL 8
> Feb 27 14:46:40 intech9 kernel: st0: Density 45, tape length: 0, drv buffer: 1
> Feb 27 14:46:40 intech9 kernel: st0: Block size: 512, buffer size: 32768 (64 blocks).
> 
> Any advice appreciated!

====================================================================
Khalid Aziz                             Linux Development Laboratory
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
