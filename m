Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAIUsy>; Tue, 9 Jan 2001 15:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbRAIUso>; Tue, 9 Jan 2001 15:48:44 -0500
Received: from lotus2.lotus.com ([192.233.136.8]:24489 "EHLO lotus2.lotus.com")
	by vger.kernel.org with ESMTP id <S129436AbRAIUs3>;
	Tue, 9 Jan 2001 15:48:29 -0500
Subject: linux-2.4.0 scsi problems on NetFinity servers
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Build V60_12122000 December 12, 2000
Message-ID: <OF0CDA4866.9019CFB7-ON852569CF.006D12FC@lotus.com>
From: "Ken Brunsen/Iris" <kenbo@iris.com>
Date: Tue, 9 Jan 2001 15:50:34 -0500
X-MIMETrack: Serialize by Router on A3MAIL/CAM/H/Lotus(Build V507_12282000 |December 28, 2000) at
 01/09/2001 03:52:41 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

     I've been sorta pulling the 2.4 kernel and testing with it now for
awhile on my IBM NetFinity 5500 and since the test12 I've been having a
continuous issue with crashing the OS during a pull of source code across
the network (>1Gb files).  I've been trying to figure out what it may be
related to, but I'm relatively new with debugging the kernel so thought I'd
see if y'all could help.  From looking at the archives, I did not see that
anyone else had been seeing these issues either.  Basically, I've got 2
different machines which I'm working with - a NetFinity Quad CPU 5500 M20
with 2Gb Ram and Raid and a NetFinity Dual CPU 5500 M10 with 1Gb Ram and
Raid.  Both machines exhibit the same behavior.  Initially, both machines
had RH 6.0, now one is RH 7.0 (and I know about the compiler issue) and the
other is SuSE 7.0.  I downloaded the 2.4.0 release and still got the issue,
so thought it was time to bring it here.  Here is a stack of one crash:

     Started getting Scsi errors on controller during NFS transfer of >1Gb
worth of files

SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 70000
I/O error: dev 08:05, sector 31731256
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 70000
I/O error: dev 08:05, sector 31731264
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 70000
I/O error: dev 08:05, sector 31731272
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 70000
I/O error: dev 08:05, sector 31731280
.
.
.

     (the sector varies from run to run, is never consistent), and then
kernel panics with the following

(ips0) Resetting controller.
NMI Watchdog detected LOCKUP on CPU1, registers:
CPU: 1
EIP: 0010:[<c0246544>]
EFLAGS: 00000002
eax: 003e240   ebx: 000612b0  ecx: 5a21a2f5   edx: 00000063
esi: 00000004  edi: 00000000  ebp:f7de2a78    esp: f7ddbf00
ds: 0018  es: 0018  ss: 0018
Process scsi_eh_0 (pid: 8, stackpage=f7ddb000)
Stack:    000003e6 c0246587 000612b0 c02465f5 000612b0 c01df470 00418570
ffffffff
     f7de2a78 00000082 00000001 200012b0 f7ddbf36 000612b0 c01dfa7c
f7de2a78
     f7de2ab8 f7de2a78 f7db1400 f7de2ab8 c01dc4ae f7de2a78 c0296220
c0295c67
Call Trace: [<c0246587>] [<c02465f5>] [<c01df470>] [<c01dfa7c>]
[<c01dc4ae>]
     [<c01bda9c>] [<c01be1db>] [<c01be4e6>] [<c01074c4>]

Code: 39 d8 72 f8 5b c3 89 f6 8b 44 24 04 eb 0e 8d b4 26 00 00 00
console shuts up ...


Thinking it could be memory related - since I see the Cache fill up and the
system go to just over 1mb free prior to crash - i disabled highmem
support.  I then disabled NFSv3 and automounter v4 support, jic.  In the
last test, I disabled swap - since one thing I've noticed is that the 2.4
kernel never touches my swap at all.  None of these changes have affected
the outcome; the closest I've gotten is by contintually doing "sync" in
another window which sometimes keeps it from crashing on a run, although
I'll still end up with a few of the SCSI disk error messages (although not
nearly as many as I get before a failure).  Since this happens on multiple
machines, I do not believe it is.  We're also seeing failures of this same
type when we try to do heavy database loading on the machine, ie., intense
disk accesses.  Any help would be greatly appreciated, as we are really
needing to get this 2.4 kernel working

Since I only get the archive list, please CC me with any responses!

Thanks!

kenbo

______________________
Firebirds rule, `stangs serve!

Kenneth "kenbo" Brunsen
Iris Associates

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
