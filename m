Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264887AbUDWReh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264887AbUDWReh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 13:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264888AbUDWReh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 13:34:37 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:31128 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S264887AbUDWReg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 13:34:36 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: mpt_linux_developer@lsil.com, linux-kernel@vger.kernel.org,
       sjralston1@netscape.net
Subject: Linux 2.6 MPT fusion bug
Date: Fri, 23 Apr 2004 17:23:52 GMT
Message-ID: <045ULNS12@server5.heliogroup.fr>
X-Mailer: Pliant 91
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reported a fiew days ago Linux 2.6 not booting with no error message
on a Dell PowerEdge 2600.

I've just tracked the problem down to a faulty SCSI cable raising a bug in MTP
fusion driver for Linux kernel 2.6, up to Linux 2.6.6-rc2

Basically, one of the SCSI cable is wrong, probably a broken wire, so the BIOS
sais that it's a narrow cable, and switches down to 40 MB/s instead of 320 MB/s

With a 2.4 kernel, the Linux driver will report a fiew such error message:
<4>SCSI Error: (1:5:0) Status=02h (CHECK CONDITION)
<4> Key=6h (UNIT ATTENTION); FRU=02h
<4> ASC/ASCQ=29h/02h "SCSI BUS RESET OCCURRED"
<4> CDB: 28 00 00 00 18 3F 00 00 08 00
and recover gracefully, and the machine works perfectly, just a little bit
slower since the disks are connected at 40 MB/s.

With 2.6, the kernel with just hang immediately with absolutely no error message.

If I change the faulty cable, both Linux 2.4 and 2.6 will run perfectly.
