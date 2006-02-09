Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422769AbWBICJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422769AbWBICJe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 21:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422770AbWBICJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 21:09:34 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50950 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422769AbWBICJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 21:09:33 -0500
Date: Thu, 9 Feb 2006 03:09:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>
Subject: pktcdvd stack usage regression
Message-ID: <20060209020932.GY3524@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

your recent patch "pktcdvd: Allow larger packets" changed 
PACKET_MAX_SIZE in the pktcdvd driver from 32 to 128.

Unfortunately, drivers/block/pktcdvd.c contains the following:

<--  snip  -->

...
static void pkt_start_write(struct pktcdvd_device *pd, struct 
packet_data *pkt)
{
        struct bio *bio;
        struct page *pages[PACKET_MAX_SIZE];
        int offsets[PACKET_MAX_SIZE];
...

<--  snip  -->

With PACKET_MAX_SIZE=128, this allocates more than 1 kB on the stack 
which is not acceptable considering that we might have only 4 kB stack 
altogether.

Please either fix this before 2.6.16 or ask Linus to revert commit 
5c55ac9bbca22ee134408f83de5f2bda3b1b2a53.

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

