Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275861AbRJYShi>; Thu, 25 Oct 2001 14:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275963AbRJYSh2>; Thu, 25 Oct 2001 14:37:28 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:522 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S275861AbRJYSh0>; Thu, 25 Oct 2001 14:37:26 -0400
Date: Thu, 25 Oct 2001 12:40:36 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: SCSI Tape Device FATAL error on 2.4.10
Message-ID: <20011025124036.A11885@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On a ServerWorks HE Chipset system with an Exabyte EXB-480 
Robotics Tape library we are seeing a fatal SCSI IO problem
that results in a SCSI bus hang on the system.  This error
is very fatal, and requires that the machine be rebooted 
to recover.   Following this error, the Linux 
Operating System is still running OK, but the affected 
SCSI bus does not respond to any commands nor do any 
devices attached to this bus.   

The Tape Drive is an Exabyte SCSI Tape.  The error occurs when
the device reaches end of tape (EOT) during a write operation
while writing to the tape.

With tape programming, there really is no good way to know where
the end of tape is while archiving data real time, so this error 
is pretty much fatal.  We are using tape partitioning, which we
have noticed not many applications in Linux use at present, so
these code paths may be related to the problem.  I have reviewed
st.c but it is not readily apparent where the problem may be
in this code, which is leading me to suspect it's related to 
some interaction between st.c and the drivers with regard to
multiple seeks and writes between tape partitions.

Configuration is:

2.4.10
AIC7XXX
ST
EXSCH (Exabyte Robotics Library for Linux 2.2.X/2.4.X) We wrote this.

The EXB-480 has 4 Exabyte tape drives and 30 150GB Tape slots with 
an import/export port.

THe system we are using is the SuperMicro Serverworks HE Motherboard with
2GB of memory and 3Ware IDE Controllers.  We are not using the 3Ware 
controllers for any of the tape support.

Please advise,

Jeff Merkey
TRG



