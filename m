Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWA3Cru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWA3Cru (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 21:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWA3Cru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 21:47:50 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32262 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751222AbWA3Crt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 21:47:49 -0500
Date: Mon, 30 Jan 2006 03:47:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: per.liden@ericsson.com, jon.maloy@ericsson.com,
       allan.stephens@windriver.com
Cc: tipc-discussion@lists.sourceforge.net, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: net/tipc/bcast.c:tipc_bcbearer_send() stack usage
Message-ID: <20060130024748.GI3777@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From net/tipc/bcast.c:

<--  snip  -->

...
int tipc_bcbearer_send(struct sk_buff *buf,
                       struct tipc_bearer *unused1,
                       struct tipc_media_addr *unused2)
{
        static int send_count = 0;

        struct node_map remains;
        struct node_map remains_new;
...

<--  snip  -->


You've just allocated 2*516 Bytes for the two structs from a stack that 
might only be 4 kB altogether.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

