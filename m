Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129197AbRCGWzi>; Wed, 7 Mar 2001 17:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131079AbRCGWz2>; Wed, 7 Mar 2001 17:55:28 -0500
Received: from enhanced.ppp.eticomm.net ([206.228.183.5]:15858 "EHLO
	intech19.enhanced.com") by vger.kernel.org with ESMTP
	id <S129197AbRCGWzL>; Wed, 7 Mar 2001 17:55:11 -0500
To: Khalid Aziz <khalid@fc.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 IDE tape problem, with ide-scsi
In-Reply-To: <54u25g3yb9.fsf_-_@intech19.enhanced.com> <3A9BC2A9.F5EE8554@fc.hp.com> <544rxg2gde.fsf@intech19.enhanced.com> <3A9BC8ED.698DCA2C@fc.hp.com> <54vgpvq4y1.fsf@intech19.enhanced.com> <3A9BEF68.72EEF0E8@fc.hp.com>
From: Camm Maguire <camm@enhanced.com>
Date: 07 Mar 2001 17:54:15 -0500
In-Reply-To: Khalid Aziz's message of "Tue, 27 Feb 2001 13:18:16 -0500"
Message-ID: <54snkpyyug.fsf@intech19.enhanced.com>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you again for your help.  While I do seem to get more errors
with the ide-tape driver, I am also seeing some problems on further
examination which are common to both ide-tape and st over ide-scsi, so
perhaps I have a bad drive or tape.

When trying to mt eom, for example, I get

=============================================================================
st0: Error: 28000000, cmd: 5 0 0 0 0 0 Len: 16
[valid=0] Info fld=0x0, Current st09:00: sns = 70  5
ASC=20 ASCQ= 0
Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x20 0x00 0x00 0x00 
st0: Can't read block limits.
st0: Mode sense. Length 11, medium b6, WBS 10, BLL 8
st0: Density 45, tape length: 0, drv buffer: 1
st0: Block size: 512, buffer size: 32768 (64 blocks).
st0: Retensioning tape.
st0: Error: 28000000, cmd: 5 0 0 0 0 0 Len: 16
[valid=0] Info fld=0x0, Current st09:00: sns = 70  5
ASC=20 ASCQ= 0
Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x20 0x00 0x00 0x00 
st0: Can't read block limits.
st0: Mode sense. Length 11, medium b6, WBS 10, BLL 8
st0: Density 45, tape length: 0, drv buffer: 1
st0: Block size: 512, buffer size: 32768 (64 blocks).
st0: Spacing tape forward over 16383 filemarks.
st0: Spacing to end of recorded medium.
st0: Error: 28000000, cmd: 11 3 0 0 0 0 Len: 16
Info fld=0x3feb, Deferred st09:00: sns = f1  3
ASC=11 ASCQ= 3
Raw sense data:0xf1 0x00 0x03 0x00 0x00 0x3f 0xeb 0x0a 0x00 0x00 0x00 0x00 0x11 0x03 0x00 0x00 
st0: Error: 28000000, cmd: 5 0 0 0 0 0 Len: 16
[valid=0] Info fld=0x0, Current st09:00: sns = 70  5
ASC=20 ASCQ= 0
Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x20 0x00 0x00 0x00 
st0: Can't read block limits.
st0: Mode sense. Length 11, medium b6, WBS 10, BLL 8
st0: Density 45, tape length: 0, drv buffer: 1
st0: Block size: 512, buffer size: 32768 (64 blocks).
st0: Rewinding tape.
=============================================================================

What is the 11,3?  Where can I find these codes listed?  Why is the
drive having trouble finding the end of the tape?  I'll be testing
more tapes soon, but this definitely happens with at least several.
The mt command returned to the prompt with 'Input/ouput error'.

Many Thanks again,

Khalid Aziz <khalid@fc.hp.com> writes:

> Camm Maguire wrote:
> > 
> > Greetings!  OK, with st debugging, here are the most common errors
> > with the Conner:
> > 
> > Feb 27 14:46:39 intech9 kernel: st0: Error: 28000000, cmd: 8 1 0 0 40 0 Len: 16
> > Feb 27 14:46:39 intech9 kernel: Info fld=0x24, Current st09:00: sns = f0  8
> > Feb 27 14:46:39 intech9 kernel: ASC=14 ASCQ= 3
> > Feb 27 14:46:39 intech9 kernel: Raw sense data:0xf0 0x00 0x08 0x00 0x00 0x00 0x24 0x0a 0x00 0x00 0x00 0x00 0x14 0x03 0x00 0x00
> > Feb 27 14:46:39 intech9 kernel: st0: Sense: f0  0  8  0  0  0 24  a
> > Feb 27 14:46:39 intech9 kernel: st0: Tape error while reading.
> 
> This was a read command that failed. Request sense information shows a
> sense key of 0x08 which is a "Blank check". This sense key indicates
> either a blank medium found or another error at EOD. ASC/ASCQ of
> 0x14/0x03 say "End-Of-Data not found". This indicates something wrong
> with the tape or maybe the drive needs cleaning. Do you get this error
> with more than one tape?
> 
> 
> > Feb 27 14:46:40 intech9 kernel: st0: Error: 28000000, cmd: 5 0 0 0 0 0 Len: 16
> > Feb 27 14:46:40 intech9 kernel: [valid=0] Info fld=0x0, Current st09:00: sns = 70  5
> > Feb 27 14:46:40 intech9 kernel: ASC=20 ASCQ= 0
> > Feb 27 14:46:40 intech9 kernel: Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x20 0x00 0x00 0x00
> > Feb 27 14:46:40 intech9 kernel: st0: Can't read block limits.
> 
> This was a "Read Block Limits" command which the drive claimed it does
> not recognize. "Read Block Limits" is a mandatory command for SCSI
> sequential access devices which is why "st" is issuing this command. The
> tape drive you have is not SCSI, so the manufacturer chose not to
> implement this command. The driver may still be able to work after "Read
> Block Limits" fails, but I have not read enough code to be sure.
> 
> > Feb 27 14:46:40 intech9 kernel: st0: Mode sense. Length 11, medium b6, WBS 10, BLL 8
> > Feb 27 14:46:40 intech9 kernel: st0: Density 45, tape length: 0, drv buffer: 1
> > Feb 27 14:46:40 intech9 kernel: st0: Block size: 512, buffer size: 32768 (64 blocks).
> > 
> > Any advice appreciated!
> 
> ====================================================================
> Khalid Aziz                             Linux Development Laboratory
> (970)898-9214                                        Hewlett-Packard
> khalid@fc.hp.com                                    Fort Collins, CO
> 
> 

-- 
Camm Maguire			     			camm@enhanced.com
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
