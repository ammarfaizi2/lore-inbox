Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293613AbSCFOha>; Wed, 6 Mar 2002 09:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293619AbSCFOhU>; Wed, 6 Mar 2002 09:37:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50448 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293613AbSCFOhJ>; Wed, 6 Mar 2002 09:37:09 -0500
Subject: Re: bitkeeper / IDE cleanup
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Wed, 6 Mar 2002 14:52:15 +0000 (GMT)
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <3C86110E.7020703@evision-ventures.com> from "Martin Dalecki" at Mar 06, 2002 01:52:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16icm7-00072w-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 3. Why do we have something like genric cdrom ioctl handling layer,
>     which is basically just adding the above hooks?

That bit is needed. You want unpriviledged processes to issue a subset of
the available commands so users can do things like play music. Those ioctls
for CDROM are also rather important for back compatibility.

Thats a seperate but important case.

There are two things I think you must consider

#1	"Make the simple things easy" - abstract common cd interface and
	friends. Unpriviledged but with strict limits on what can be issued

#2	"Make the hard possible" - the direct "I know what I am doing"
	CAP_SYS_RAWIO interface

#3	Ioctls that must be issued with kernel help because they change
	interface status and must synchronize both the device and the
	controller (eg 'go to UDMA3')

What can hopefully go is ioctls that are complex, setuid required and 
could be done by #2.

Alan
