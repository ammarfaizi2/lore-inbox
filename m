Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265432AbSJaW3p>; Thu, 31 Oct 2002 17:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265435AbSJaW3p>; Thu, 31 Oct 2002 17:29:45 -0500
Received: from vsmtp4.tin.it ([212.216.176.224]:64762 "EHLO smtp4.cp.tin.it")
	by vger.kernel.org with ESMTP id <S265432AbSJaW3j>;
	Thu, 31 Oct 2002 17:29:39 -0500
Message-ID: <3DC1B03C.7FDB86E3@denise.shiny.it>
Date: Thu, 31 Oct 2002 23:35:40 +0100
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.19 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: aic7xxx and error recovery
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a magneto-optical drive. Recoverable error rate is quite high
in this kind of devices (1 bit every 10^5, according to specs, but
it's actually much lower IMHO). I was playing with the SCSI error
recovery page and I noticed that when I enable the PER flag (which
makes the drive to tell the initiator when a recoverable medium
error occurs) strange things happen. I wrote a small prg that writes
random patterns and then reads it back and compare it with the
pattern. It happens that when a recoverable error occurs (as
reported in the sys logs) read()(2) returns a value smaller then
requested, and the loaded data is identical to the pattern, or
read() completes, but the data is wrong. This two cases seem to
be mutually exclusive, I've tried a lot of times. I don't know why
this happens, but IMO if read(length)==length then the data I get
shouldn't be corrupted. I believe there is a bug in the scsi
driver, because if PER==0 I never get corrupted data, and PER==1
doesn't affects data sent to the initiator, it only reports
recovered errors. Comments ?

[Linux Jay 2.4.19 #3 mer ago 14 15:29:00 CEST 2002 ppc unknown]

Bye.
