Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317399AbSGOJ0W>; Mon, 15 Jul 2002 05:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317404AbSGOJ0V>; Mon, 15 Jul 2002 05:26:21 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:51730 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id <S317399AbSGOJ0T>; Mon, 15 Jul 2002 05:26:19 -0400
From: "" <simon@baydel.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 15 Jul 2002 09:11:34 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: scsi detect and kgdb
Message-ID: <3D3291C6.2253.2B2C10@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been writing a scsi module and as part of the module 
initialisation I would like to delay while waiting for a specific 
condition. I have tried to put the detect routine in a loop which 
spins on jiffies + a timeout and my hardware condition. I had all 
sorts of problems with this code and I found that module load 
locked up. I tried using barrier and schedule in this loop and found 
that schedule worked for me most of the time. 

I thought I would have a look at the code with kgdb. Firstly I noticed 
that schedule is not defined in the kgdb enabled kernel. Also even 
if I put this detect routine in a spin for a while my interrupts do not 
get serviced until after this spin and quite possibly not until the 
detect routine returns.

I would like to know the correct way to facilitate a delay in a scsi 
module detect routine, while waiting for a hardware condition which 
gets satisfied by a number of interrupts. If this condition is not met 
in a timeout period the code also continue.

I would also like to understand the kgdb kernel behaviour.

I am running a 2.4.16 kernel.


Cheers 

Simon.
__________________________

Simon Haynes - Baydel 
Phone : 44 (0) 1372 378811
Email : simon@baydel.com
__________________________
