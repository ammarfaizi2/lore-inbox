Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbTKBQXn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 11:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbTKBQXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 11:23:43 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:22710 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S261746AbTKBQXl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 11:23:41 -0500
Message-ID: <1067790219.3fa52f8bc8af5@imp2-a.free.fr>
Date: Sun,  2 Nov 2003 17:23:39 +0100
From: =?iso-8859-1?b?R3fpbmHrbA==?= Cotrez <gcotrez@jetmultimedia.net>
To: linux-kernel@vger.kernel.org
Subject: Question about /proc/partitions
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm developing a system accounting, which get informations about I/O in
/proc/partitions.
But, I've noticed that sometimes this system returns informations about negative
I/O.
I find this in in the kernel tree source :
http://lxr.linux.no/source/include/linux/genhd.h?v=2.4.22#L61

61 struct hd_struct {
...........
69         /* Performance stats: */
70         unsigned int ios_in_flight;
71         unsigned int io_ticks;
72         unsigned int last_idle_time;
73         unsigned int last_queue_change;
74         unsigned int aveq;
75        
76         unsigned int rd_ios;
77         unsigned int rd_merges;
78         unsigned int rd_ticks;
79         unsigned int rd_sectors;
80         unsigned int wr_ios;
81         unsigned int wr_merges;
82         unsigned int wr_ticks;
83         unsigned int wr_sectors;       
84 #endif /* CONFIG_BLK_STATS */
85 };

but in http://lxr.linux.no/source/drivers/block/genhd.c?v=2.4.22#L181

static int part_show(struct seq_file *s, void *v)
.............
189 #ifdef CONFIG_BLK_STATS
190                             "     rio rmerge rsect ruse wio wmerge "
191                             "wsect wuse running use aveq"
......
203                         seq_printf(s, "%4d  %4d %10d %s "                  
                <------
204                                       "%d %d %d %d %d %d %d %d %d %d %d\n",
     <------
205                                       gp->major, n, gp->sizes[n],
206                                       disk_name(gp, n, buf),
207                                       hd->rd_ios, hd->rd_merges,
208 #define MSEC(x) ((x) * 1000 / HZ)
209                                       hd->rd_sectors, MSEC(hd->rd_ticks),
210                                       hd->wr_ios, hd->wr_merges,
211                                       hd->wr_sectors, MSEC(hd->wr_ticks),
212                                       hd->ios_in_flight, MSEC(hd->io_ticks),
213                                       MSEC(hd->aveq));
.....................
223 }

I think that negative I/O result of the usage of %d in seq_printf function for
variable declared as  unsigned int.
Somebody could confirm me this

Thank's

