Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276616AbRI2UsC>; Sat, 29 Sep 2001 16:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274964AbRI2Urw>; Sat, 29 Sep 2001 16:47:52 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:14354 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S276616AbRI2Urg>; Sat, 29 Sep 2001 16:47:36 -0400
Date: Sat, 29 Sep 2001 16:48:00 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: Andre Hedrick <andre@aslab.com>
cc: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: RFC (patch below) Re: ide drive problem?
In-Reply-To: <Pine.LNX.4.10.10109291309050.28810-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.10.10109291627300.9176-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is an error that I am considering removing form the user's view.
> For the very fact/reason you are pointing out; however, it becomse
> more painful when performing error sorting.

yes, most of the time, the warning scares people unnecessarily.
but if the machine is seeing lots of CRC failures, there should 
definitely be some prominent messages.  perhaps something simple
like producing a warning if more than a few of recent IOs
have had CRC problems:

int crcState = 0;

on successful IO: 
	crcState >>= 1;

on CRC failure: 
	if (crcState)
		printk("dang, CRC failed on hda, see http://whatever");
	crcState = 1 << 10;

so if >10 IOs succeed between CRC failures, there's no warning.
(uh, I guess that would actually be 9, since presumably the retry
would succeed...)  keeping a global count of CRC failures would be
kind of nice, too.

regards, mark hahn.

