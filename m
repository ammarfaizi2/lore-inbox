Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284837AbRLEXl6>; Wed, 5 Dec 2001 18:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284838AbRLEXls>; Wed, 5 Dec 2001 18:41:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61959 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284837AbRLEXlg>; Wed, 5 Dec 2001 18:41:36 -0500
Subject: Re: Linux/Pro  -- clusters
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 5 Dec 2001 23:49:43 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9um58i$9no$1@penguin.transmeta.com> from "Linus Torvalds" at Dec 05, 2001 09:57:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BlnL-00080m-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> by the better generic block layer code.  I personally hope that a year
> from now, if somebody wants to do a new SCSI driver, he won't even
> _think_ about using the SCSI code, the driver will just take the
> (generic SCSI) requests directly off the block queue. 

You still need the scsi code. There are a whole sequence of common, quite
complex and generic functions that the scsi layer handles (in paticular
error handling).

Turning it the right way I up definitely agree with. It should be the driver
calling the scsi code to do bio->scsi request, and to do scsi error
recovery, not vice versa.

There are also some tricky relationships
	queues are per logical unit number
	locking is mostly per controller
	resources are often per controller

Alan

	
