Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSIMU5t>; Fri, 13 Sep 2002 16:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319583AbSIMU5t>; Fri, 13 Sep 2002 16:57:49 -0400
Received: from [195.39.17.254] ([195.39.17.254]:22400 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316599AbSIMU5t>;
	Fri, 13 Sep 2002 16:57:49 -0400
Date: Fri, 13 Sep 2002 23:00:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rik van Riel <riel@conectiva.com.br>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Good way to free as much memory as possible under 2.5.34?
Message-ID: <20020913210042.GA25464@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

/*
 * Try to free as much memory as possible, but do not OOM-kill anyone
 *
 * Notice: all userland should be stopped at this point, or livelock
is possible.
 */

This worked before -rmap came in, but it does not free anything
now. What needs to be done to fix it?

								Pavel 

static void free_some_memory(void)
{
        printk("Freeing memory: ");
        while
(try_to_free_pages(&contig_page_data.node_zones[ZONE_HIGHMEM], GFP_KSWAPD, 0))
                printk(".");
        printk("|\n");
}

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
