Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264956AbTK3RTs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 12:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264959AbTK3RTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 12:19:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:46569 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264956AbTK3RTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 12:19:42 -0500
X-Authenticated: #4512188
Message-ID: <3FCA26AA.90302@gmx.de>
Date: Sun, 30 Nov 2003 18:19:38 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Jeff Garzik <jgarzik@pobox.com>, marcush@onlinehome.de, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: Silicon Image 3112A SATA trouble
References: <3FC36057.40108@gmx.de> <200311301547.32347.bzolnier@elka.pw.edu.pl> <3FCA1220.2040508@gmx.de> <200311301721.41812.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200311301721.41812.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> In 2.6.x there is no max_kb_per_request setting in /proc/ide/hdx/settings.
> Therefore
> 	echo "max_kb_per_request:128" > /proc/ide/hde/settings
> does not work.
> 
> Hmm. actually I was under influence that we have generic ioctls in 2.6.x,
> but I can find only BLKSECTGET, BLKSECTSET was somehow lost.  Jens?
> 
> Prakash, please try patch and maybe you will have 2 working drivers now :-).


OK, this driver fixes the transfer rate problem. Nice, so I wanted to do 
the right thing, but it didn't work, as you explained... Thanks.

Nevertheless there is still the issue left:

hdparm -d1 /dev/hde makes the drive get major havoc (something like: 
ide: dma_intr: status=0x58 { DriveReady, SeekCOmplete, DataRequest}

ide status timeout=0xd8{Busy}; messages taken from swsups kernal panic
). Have to do a hard reset. I guess it is the same reason why swsusp 
gets a kernel panic when it sends PM commands to siimage.c. (Mybe the 
same error is in libata causing the same kernel panic on swsusp.)

Any clues?

Nice that at least the siimage driver has got some improvement after me 
getting on your nerves. ;-)

Prakash

