Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbUK1GFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbUK1GFr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 01:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbUK1GFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 01:05:47 -0500
Received: from tim.plush.org ([168.150.236.223]:17833 "EHLO tim.plush.org")
	by vger.kernel.org with ESMTP id S261401AbUK1GFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 01:05:39 -0500
Date: Sat, 27 Nov 2004 22:05:38 -0800
From: Gabriel Rosa <grosa@plush.org>
To: linux-kernel@vger.kernel.org
Subject: sil 3112 sata == slow + high cpu
Message-ID: <20041128060537.GA5261@foo.plush.org>
Mail-Followup-To: Gabriel Rosa <grosa@plush.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings,

I'm having some problems with a Sil 3112 2 port SATA card (pci). It
seems to work fine (ie, drives are accessible), mostly, with kernel 2.6.8.

More precisely, the card is (according to lspci): 

0000:02:04.0 RAID bus controller: Silicon Image, Inc. (formerly CMD
Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller
(rev 01)

My setup is an athlon mp box, with dual maxtor 250g sata drives. The
controller works great on individual drives, but horribly when both
drives are accessed simultaniously. Both drives show up through the
scsi subsystem (sda and sdb) and claim Direct-Access.

I have both drives in a software RAID1, and have seen the following
behaviour:

1) rebuilding the array causes extremely high system load if the rebuild
rate is higher than 500kB/s

2) doing a: time dd if=/dev/zero of=temp.raw bs=1024M count=1

yields:

real    68m50.066s
user    0m0.000s
sys     0m0.001s


During these 68m, the load oscillated from 15.00 to just under 30.00,
making the machine mostly unuseable. I noticed that temp.raw would remain
the same size for long periods of time, then suddenly increase by 80mb
or so, sometimes less. If less, then the time it took between bursts
was also shorter.

on the read side, similar but not as pronounced behaviour:

# time dd if=temp.raw of=/dev/null count=1 bs=1024M

real    9m6.806s
user    0m0.002s
sys     0m12.679s

During these 9m, the load oscillated between 3.5 and 4.1

Out of the blue, I'd guess this is some strange interrupt issue, but I'm
not familiar enough with the libata or sata_sil drivers to really know.

thanks for any input,
-Gabe
