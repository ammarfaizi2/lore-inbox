Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272135AbRIJXHa>; Mon, 10 Sep 2001 19:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272122AbRIJXHL>; Mon, 10 Sep 2001 19:07:11 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:51730 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S272121AbRIJXG0>; Mon, 10 Sep 2001 19:06:26 -0400
Message-Id: <200109102306.f8AN6iY21834@aslan.scsiguy.com>
To: SPATZ1@t-online.de (Frank Schneider)
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: AIC + RAID1 error? (was: Re: aic7xxx errors) 
In-Reply-To: Your message of "Tue, 11 Sep 2001 00:55:13 +0200."
             <3B9D44D1.E96C831F@t-online.de> 
Date: Mon, 10 Sep 2001 17:06:44 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>What about a kind of timer ?

The functions are run serially.  If I'm to wait, I must block
or risk having the machine powered off prior to completing my shutdown.

A coworker of mine playing with the MD code reminded me that
he had to change the priority of the MD notifier to make it work.
I believe that this is the correct fix as there are other SCSI
drivers that have shutdown hooks.

All HBA drivers currently use 0 (or the lowest) as their priority.
MD (line 3475 of drivers/md/md.c) uses 0 too.  Change it to INT_MAX
and MD will always get shutdown prior to any child devices it might
use.

--
Justin
