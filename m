Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262187AbSKDQmk>; Mon, 4 Nov 2002 11:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262497AbSKDQmk>; Mon, 4 Nov 2002 11:42:40 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:41476 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id <S262187AbSKDQmj>; Mon, 4 Nov 2002 11:42:39 -0500
From: "" <simon@baydel.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 4 Nov 2002 09:40:59 -0000
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: halt and schedule
Message-ID: <3DC640AB.12893.F77CB@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have been changing 2.4.19 to run on some new hardware, X86 
based. The system boots and runs off a ramdisk. I am having 
problems which I see as pauses. The system starts up and loads 
the kernel. All seems ok until the ramdisk is mouned and INIT is 
started. From this point on the system appears to stop responding 
for a few seconds and then start again. Eventually, when logged in 
command input can be slow with pauses between entering a 
character and the console displaying the character.


I have tried to debug this and found that the kernel is in the 
cpu_idle() routine which is repeatedly calling default_idle() and
safe_halt(). If you then type a character on the console, using a
scope, you can see the interrupt being serviced and a character 
being taken from the RX fifo, quickly. However there is no
response for some seconds. I have also noticed that if you keep the
thing busy with a benchmark or something simple like ls -lR there is
no pause.  

I noticed that to get out of this loop the kernel is looking for a
process to schedule. It is as if the process is not being scheduled 
as soon as it could be.

One point to consider is that this board has no RTC or CTC just the 
timer wired to a 10ms interrupt.

I suspect that this is a hardware problem but I don't really know
where to start looking. Can anyone help ?

Many thanks

Simon.
__________________________

Simon Haynes - Baydel 
Phone : 44 (0) 1372 378811
Email : simon@baydel.com
__________________________
