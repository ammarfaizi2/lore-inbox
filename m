Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbTH3Itt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 04:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbTH3Itt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 04:49:49 -0400
Received: from tmi.comex.ru ([217.10.33.92]:60315 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S262945AbTH3Itr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 04:49:47 -0400
X-Comment-To: Ed Sweetman
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [RFC] extents support for EXT3
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
References: <m33cfm19ar.fsf@bzzz.home.net> <3F4E4605.6040706@wmich.edu>
	<m3vfshrola.fsf@bzzz.home.net> <3F4F7129.1050506@wmich.edu>
	<m3vfsgpj8b.fsf@bzzz.home.net> <3F4F76A5.6020000@wmich.edu>
	<m3r834phqi.fsf@bzzz.home.net> <3F4F7D56.9040107@wmich.edu>
	<m3isogpgna.fsf@bzzz.home.net> <3F4F923F.9070207@wmich.edu>
Date: Sat, 30 Aug 2003 12:55:15 +0400
Message-ID: <m31xv3plsc.fsf@bzzz.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Ed Sweetman (ES) writes:

 ES> I booted with test4-mm2 patched

 ES> Throughput 221.812 MB/sec 16 procs    ext2
 ES> Throughput 159.495 MB/sec 16 procs    ext3-extents (definitely enabled)
 ES> Throughput 147.598 MB/sec 16 procs    ext3 (patched but disabled)

 ES> There is an obvious improvement, but nothing near the 70+% increase
 ES> you saw.  Subsequent runs run anything from a little lower than above
 ES> for extents to 167MB/s.

yep. Andrew pointed out that I was using SMP on testbox. so, I reran tests on UP:

[root@zefir root]# vim /root/db2.sh 
[root@zefir root]# /root/db2.sh 2 16
Throughput 116.412 MB/sec 16 procs
Throughput 108.163 MB/sec 16 procs
Average: 112.28750

[root@zefir root]# /root/db2.sh 2 16
Throughput 120.401 MB/sec 16 procs
Throughput 118.392 MB/sec 16 procs
Average: 119.39650

on UP improvement is about 6% (8% in your case). this result looks much more fair.

now I have following items on todo list:
1) debugfs support
   I really need it in order to understand extents usage for diff apps. having
   this info we could tune extents for more improvements
2) multiblock allocation
3) delayed allocation

thank you, Ed!

