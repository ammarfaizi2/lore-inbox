Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWEOXa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWEOXa3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWEOXa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:30:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:30551 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750771AbWEOXa2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:30:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zu7ib7XmVbR5cQYLkb4hRi3qTr0z8+3ZTjAX608n29HAn8a4vxe9XVxsYRTxWwzUse7XaRDoFNUKf6N/hIgoKzydtkSvSulLWo2fQsHZ9yAnj8kgFQ/8Aaz5keDRTubTGQFCMZdv2Tvj86EkeX3MwXbuTnI+kevGM27O6vtq+LM=
Message-ID: <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com>
Date: Mon, 15 May 2006 16:30:26 -0700
From: "Avuton Olrich" <avuton@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: [RFT] major libata update
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org
In-Reply-To: <20060515170006.GA29555@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060515170006.GA29555@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/06, Jeff Garzik <jeff@garzik.org> wrote:
> * sata_sil and ata_piix also need healthy re-testing of all basic
> functionality.

I'm testing it right now, but with 2.6.17-rc4-git2 I was getting:

May 15 15:42:57 shapeshifter ata2: command 0x25 timeout, stat 0x58 host_stat 0x1
May 15 15:42:57 shapeshifter ata2: translated ATA stat/err 0x58/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
May 15 15:42:57 shapeshifter ata2: status=0x58 { DriveReady
SeekComplete DataRequest }
May 15 15:42:57 shapeshifter sd 1:0:0:0: SCSI error: return code = 0x8000002
May 15 15:42:57 shapeshifter sda: Current: sense key=0xb
May 15 15:42:57 shapeshifter ASC=0x47 ASCQ=0x0
May 15 15:42:57 shapeshifter end_request: I/O error, dev sda, sector 974708575

(sector varies)

After large ssh transfers. I moved to 2.6.17-rc4-git2 because
2.6.16.16 was doing the same. This is a new 500gb sata2 drive on
sata_sil so I guess this could be hardware, but I wanted to make sure
before I go returning this thing. After this obviously I have to sysrq
sync, ro and reboot. This also causes(?) a NETDEV WATCHDOG: eth2:
transmit timed out, sometimes this ata timeout doesn't yet occur and I
just get the netdev watchdog. This has not yet happened with the new
patch, though I'm only 1 hr into testing with it.


If you want to take a peek at my config:
http://olricha.homelinux.net:8080/ss.config
-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
