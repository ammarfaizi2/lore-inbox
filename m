Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130707AbRCMAmr>; Mon, 12 Mar 2001 19:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130719AbRCMAmi>; Mon, 12 Mar 2001 19:42:38 -0500
Received: from ohiper1-204.apex.net ([209.250.47.219]:40196 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S130707AbRCMAm3>; Mon, 12 Mar 2001 19:42:29 -0500
Date: Mon, 12 Mar 2001 18:45:18 -0600
From: Steven Walter <srwalter@yahoo.com>
To: rusty@linuxcare.com
Cc: linux-kernel@vger.kernel.org
Subject: Trouble with an ip_conntrack_helper
Message-ID: <20010312184518.A4793@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 6:39pm  up  2:25,  1 user,  load average: 1.01, 1.10, 1.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting some interesting behavior while writing an ip_conntrack
helper module.  The primary problem is if I specify a destination port
for the struct ip_conntrack_helper, my help routine is never called.
If I specify a source port, rather than a destination port, the routine
gets called for the various packets in the desired connection.

The problem with this is that I my routine doesn't start getting called
until a packet in the opposite direction arrives, and all packets before
that are never sent by my module.  This makes sense, as the tuple
specifies a /source/ port, which would only occur on reverse traffic.

Here is the chunk of code I'm using to register my helper.  Is there
something really obvious that I'm missing.  I really appreciate any help
you can give.

static struct ip_conntrack_helper icq;

static int __init init(void) {
        memset(&icq, 0, sizeof(struct ip_conntrack_helper));
        icq.tuple.dst.protonum = IPPROTO_UDP;
        icq.tuple.dst.u.udp.port = __constant_htons(4000);
        icq.mask.dst.protonum = 0xffff;
        icq.mask.dst.u.udp.port = 0xffff;
        icq.help = help;
        printk(KERN_INFO "ip_conntrack_icq: registered\n");
        return ip_conntrack_helper_register(&icq);
}


-- 
-Steven
Never ask a geek why, just nod your head and slowly back away.
