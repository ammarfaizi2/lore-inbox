Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278450AbRJZMAj>; Fri, 26 Oct 2001 08:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278449AbRJZMA3>; Fri, 26 Oct 2001 08:00:29 -0400
Received: from uucp.cistron.nl ([195.64.68.38]:44048 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S278374AbRJZMAW>;
	Fri, 26 Oct 2001 08:00:22 -0400
From: "Rob Turk" <r.turk@chello.nl>
Subject: Re: SCSI Tape Device FATAL error on 2.4.10
Date: Fri, 26 Oct 2001 14:00:56 +0200
Organization: Cistron Internet Services B.V.
Message-ID: <9rbj9p$8tr$1@ncc1701.cistron.net>
In-Reply-To: <20011025124036.A11885@vger.timpanogas.org>
X-Trace: ncc1701.cistron.net 1004097658 9147 193.78.180.30 (26 Oct 2001 12:00:58 GMT)
X-Complaints-To: abuse@cistron.nl
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" <jmerkey@vger.timpanogas.org> wrote in message
news:cistron.20011025124036.A11885@vger.timpanogas.org...
>
>
> On a ServerWorks HE Chipset system with an Exabyte EXB-480
> Robotics Tape library we are seeing a fatal SCSI IO problem
> that results in a SCSI bus hang on the system.  This error
> is very fatal, and requires that the machine be rebooted
> to recover.   Following this error, the Linux
> Operating System is still running OK, but the affected
> SCSI bus does not respond to any commands nor do any
> devices attached to this bus.
>
> The Tape Drive is an Exabyte SCSI Tape.  The error occurs when
> the device reaches end of tape (EOT) during a write operation
> while writing to the tape.
>
> With tape programming, there really is no good way to know where
> the end of tape is while archiving data real time, so this error
> is pretty much fatal.  We are using tape partitioning, which we
> have noticed not many applications in Linux use at present, so
> these code paths may be related to the problem.  I have reviewed
> st.c but it is not readily apparent where the problem may be
> in this code, which is leading me to suspect it's related to
> some interaction between st.c and the drivers with regard to
> multiple seeks and writes between tape partitions.
>

Jeff,

Logical end-of-tape handling is clearly defined in Exabyte's SCSI reference
manual which you can download from their web page. There's nothing fatal
about it, your application should handle it. The SCSI Write command that
reaches logical end-of-tape (or end-of-partition) will end with a Check
condition, Sense key 0h, ASC=00h, ASCQ=00h, EOM bit = 1. Your data will be
written to tape just fine. There is plenty of tape left so you can
gracefully write a delimiting filemark or whatever you need to close the
current data set. All write commands after reaching LEOT will also result in
a Check Condition with the above sense information (until you really run out
of tape). It's a Logical end-of-tape you deal with, not a Physical one.

As a side note, make sure you have the latest firmware loaded in your M2
drives.

Rob




