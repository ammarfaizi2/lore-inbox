Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVCYSTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVCYSTC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 13:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVCYSSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 13:18:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37898 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261723AbVCYSSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 13:18:38 -0500
Date: Fri, 25 Mar 2005 19:18:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: drivers/net/at1700.c: at1700_probe1: array overflow
Message-ID: <20050325181836.GB3153@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker found the following:

<--  snip  -->

...
static int at1700_ioaddr_pattern[] __initdata = {
        0x00, 0x04, 0x01, 0x05, 0x02, 0x06, 0x03, 0x07
};
...
static int __init at1700_probe1(struct net_device *dev, int ioaddr)
{
...
	for (l_i = 0; l_i < 0x09; l_i++)
		if (( pos3 & 0x07) == at1700_ioaddr_pattern[l_i])
			break;
	ioaddr = at1700_mca_probe_list[l_i];
...
}
...

<--  snip  -->


This can result in indexing in an array with 8 entries the 10th entry.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


