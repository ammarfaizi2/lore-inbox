Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278832AbRJZSob>; Fri, 26 Oct 2001 14:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278833AbRJZSoL>; Fri, 26 Oct 2001 14:44:11 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:36365 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S278832AbRJZSoJ>; Fri, 26 Oct 2001 14:44:09 -0400
Date: Fri, 26 Oct 2001 12:47:16 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Rob Turk <r.turk@chello.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI Tape Device FATAL error on 2.4.10
Message-ID: <20011026124716.B18026@vger.timpanogas.org>
In-Reply-To: <20011025124036.A11885@vger.timpanogas.org> <9rbj9p$8tr$1@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9rbj9p$8tr$1@ncc1701.cistron.net>; from r.turk@chello.nl on Fri, Oct 26, 2001 at 02:00:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2001 at 02:00:56PM +0200, Rob Turk wrote:
> "Jeff V. Merkey" <jmerkey@vger.timpanogas.org> wrote in message
> news:cistron.20011025124036.A11885@vger.timpanogas.org...
> >
> >
> > On a ServerWorks HE Chipset system with an Exabyte EXB-480
> > Robotics Tape library we are seeing a fatal SCSI IO problem
> > that results in a SCSI bus hang on the system.  This error
> > is very fatal, and requires that the machine be rebooted
> > to recover.   Following this error, the Linux
> > Operating System is still running OK, but the affected
> > SCSI bus does not respond to any commands nor do any
> > devices attached to this bus.
> >
> > The Tape Drive is an Exabyte SCSI Tape.  The error occurs when
> > the device reaches end of tape (EOT) during a write operation
> > while writing to the tape.
> >
> > With tape programming, there really is no good way to know where
> > the end of tape is while archiving data real time, so this error
> > is pretty much fatal.  We are using tape partitioning, which we
> > have noticed not many applications in Linux use at present, so
> > these code paths may be related to the problem.  I have reviewed
> > st.c but it is not readily apparent where the problem may be
> > in this code, which is leading me to suspect it's related to
> > some interaction between st.c and the drivers with regard to
> > multiple seeks and writes between tape partitions.
> >
> 
> Jeff,
> 
> Logical end-of-tape handling is clearly defined in Exabyte's SCSI reference
> manual which you can download from their web page. There's nothing fatal
> about it, your application should handle it. The SCSI Write command that
> reaches logical end-of-tape (or end-of-partition) will end with a Check
> condition, Sense key 0h, ASC=00h, ASCQ=00h, EOM bit = 1. Your data will be
> written to tape just fine. There is plenty of tape left so you can
> gracefully write a delimiting filemark or whatever you need to close the
> current data set. All write commands after reaching LEOT will also result in
> a Check Condition with the above sense information (until you really run out
> of tape). It's a Logical end-of-tape you deal with, not a Physical one.
> 
> As a side note, make sure you have the latest firmware loaded in your M2
> drives.
> 
> Rob
> 

I am using st.o and it is not handling this condition correctly under
Linux.  It has nothing to do with your firmware.  I am programming 
the robot directly over SCSI, but I am going through the Linux tape support 
module st.c for tape drive support.  When this error occurs, the 
entire SCSI bus gets hosed in some of the failure cases.   Sounds like 
I need to submit a patch to st.c

:-)

Jeff

> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
