Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261395AbTCOFio>; Sat, 15 Mar 2003 00:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261397AbTCOFio>; Sat, 15 Mar 2003 00:38:44 -0500
Received: from holomorphy.com ([66.224.33.161]:21200 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261395AbTCOFin>;
	Sat, 15 Mar 2003 00:38:43 -0500
Date: Fri, 14 Mar 2003 21:49:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: bzzz@tmi.comex.ru, adilger@clusterfs.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-ID: <20030315054910.GN20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, bzzz@tmi.comex.ru,
	adilger@clusterfs.com, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <m3el5bmyrf.fsf@lexa.home.net> <20030313015840.1df1593c.akpm@digeo.com> <m3of4fgjob.fsf@lexa.home.net> <20030313165641.H12806@schatzie.adilger.int> <m38yvixvlz.fsf@lexa.home.net> <20030315043744.GM1399@holomorphy.com> <20030314205455.49f834c2.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030314205455.49f834c2.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 08:54:55PM -0800, Andrew Morton wrote:
> `dbench 512' will presumably do lots of IO and spend significant
> time in I/O wait.  You should see the effects of this change more
> if you use fewer clients (say, 32) so it doesn't hit disk.

Throughput 226.57 MB/sec 32 procs
dbench 32 2>& 1  25.04s user 515.02s system 1069% cpu 50.516 total

vma      samples  %-age       symbol name
c0106ff4 1877599  35.8654     default_idle
c01dc3b0 586997   11.2127     __copy_to_user_ll
c0108140 193213   3.6907      .text.lock.semaphore
c015249a 137467   2.62586     .text.lock.file_table
c01dc418 117981   2.25364     __copy_from_user_ll
c01dc59c 115415   2.20463     .text.lock.dec_and_lock
c016997b 106198   2.02857     .text.lock.dcache
c0119dac 98439    1.88036     scheduler_tick
c01dc510 95745    1.8289      atomic_dec_and_lock
c0119058 91746    1.75251     try_to_wake_up
c011fadc 88996    1.69998     profile_hook
c0107d0c 84514    1.61436     __down
c01522a0 70518    1.34702     file_move
c011a1bc 68364    1.30587     schedule
c011c4ff 59716    1.14068     .text.lock.sched
c0168aac 58337    1.11434     d_lookup
c015f3dc 58111    1.11002     path_lookup
c0119860 55141    1.05329     load_balance

procs -----------memory---------- -----io---- --system-- ----cpu----
 r  b   free   buff    cache   bi    bo        in    cs   us sy id wa
11  0 47538048 549664 737120    0     0       1028 12123   2 33 65  0
 6  2 47534592 550880 738272    0 16312       1085 12498   2 28 67  3
15  2 47559680 552064 711936    0  2332       1111 12197   2 30 63  6
10  3 47539648 547808 737344    0  5012       1174 12683   2 28 63  8
13  4 47585600 548736 689728    0  1616       1173 12393   2 31 58  8
17  2 47575680 550432 699264    0  2252       1224 12135   2 35 54  8
31  2 47643008 550944 631712    0  2216       1189  4795   2 82 15  2
28  1 47724288 551296 548320    0  2532       1178  4297   2 77 18  4
25  2 47798464 552032 473824    0  2724       1199  3283   2 73 22  3
12  5 48026944 552096 243296    0  2272       1170  4389   2 54 37  7
 0  9 48201344 552160  69696    0  3480       1167   466   0  8 62 29
 1  4 48206720 552160  64512    0  3252       1173   152   0  0 83 16
 1  2 48210880 552160  60864    0  3232       1163   106   0  0 90  9
 2  2 48210880 552160  60864    0  3592       1163   111   0  0 93  6
 1  8 48256320 552160  36928    0  3008       1146   587   0  2 79 20
 2  7 48264128 552160  30016    0  3488       1153   170   0  0 76 24
 2  6 48268544 552160  26912    0  3012       1151   145   0  0 79 21
 2  5 48273408 552160  22400    0   312       1162   116   0  0 83 16
 4  0 48277248 552160  21056   12     8       1051   184   0  1 97  1
 0  0 48280448 552160  21280    0     0       1033    59   0  0 100 0
