Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292017AbSCFATg>; Tue, 5 Mar 2002 19:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291043AbSCFATS>; Tue, 5 Mar 2002 19:19:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57610 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290946AbSCFATG>; Tue, 5 Mar 2002 19:19:06 -0500
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Wed, 6 Mar 2002 00:33:55 +0000 (GMT)
Cc: axboe@suse.de (Jens Axboe), zwane@linux.realnet.co.sz (Zwane Mwaikambo),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <3C84B1FB.2050003@evision-ventures.com> from "Martin Dalecki" at Mar 05, 2002 12:54:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16iPNT-0004tb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No quite my plan is:
> 
> 1. Rip it off.
> 2. Reimplement stuff if and only if someone really shows pressure
> for using it.
> 
> The "command parsing" excess is certainly going to go.

Its maybe handy actually. Without command parsing I can tell the drive to
do anything without good control - you know say like all the upcoming SSSCA
encrypt chunks of your harddisk so you can never get them back stuff.

The important bit is that for each command you must know the sequence of
phases. Get it wrong and your storage system goes off to visit undefined
states. I don't like my disks in undefined states because it tends to leave
them with undefined content.

Two things I do think wants considering

#1	Can the same thing be done by passing the command and sequence of
	transitions from user space (scsi generic takes that approach but
	scsi is a little more forgiving since the bogus transition will
	screw your command in a "oh whoops" detectable manner). IDE
	has a nice habit of explaining you screwed up by scribbling on
	the disk and/or locking solid

#2	Shoot all the little routines and make them into a table.

That would tidy it no end. 

