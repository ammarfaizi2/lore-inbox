Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267294AbUBNAQQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 19:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267296AbUBNAQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 19:16:16 -0500
Received: from holomorphy.com ([199.26.172.102]:33482 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267294AbUBNAP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 19:15:59 -0500
Date: Fri, 13 Feb 2004 16:15:56 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: nfs@lists.sourceforge.net
Subject: 2.6.2-rc2-mm2 server-side nfs pathology
Message-ID: <20040214001556.GL699@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Basically, this thing is either not making forward progress or is
pathologically slow (I left this running overnight without visible
forward progress, though the log doesn't cover that period). I'm not
sure how to make sense of the tcpdump log for nfs requests. The nfsroot
machine in older 2.4 (2.4.14, which is the last/only working Linux
kernel version I have for the machine) and NetBSD both get stuck in
what appears to be a retry loop for some kind of nfs request that
2.6.2-rc2-mm2 is not answering to its satisfaction.

Below is a tcpdump trace of NetBSD attempting to boot, started at some
point toward the end of the tftpboot process.


-- wli


tcpdump: listening on eth3
11:47:18.609524 meromorphy.holomorphy.com.bootps > residue.holomorphy.com.bootpc:  xid:0x1ffffff Y:residue.holomorphy.com S:meromorphy.holomorphy.com file ""[|bootp] [tos 0x10] 
11:47:18.612867 meromorphy.holomorphy.com.bootps > residue.holomorphy.com.bootpc:  xid:0x1ffffff Y:residue.holomorphy.com S:meromorphy.holomorphy.com file ""[|bootp] [tos 0x10] 
11:47:18.818479 arp who-has residue.holomorphy.com tell residue.holomorphy.com
11:47:21.967521 arp who-has meromorphy.holomorphy.com tell residue.holomorphy.com
11:47:21.967582 arp reply meromorphy.holomorphy.com is-at 0:20:78:1e:2b:94
11:47:21.968241 residue.holomorphy.com.1023 > meromorphy.holomorphy.com.sunrpc: udp 76
11:47:21.968921 meromorphy.holomorphy.com.sunrpc > residue.holomorphy.com.1023: udp 28 (DF)
11:47:21.970619 residue.holomorphy.com.1023 > meromorphy.holomorphy.com.872: udp 80
11:47:22.047314 meromorphy.holomorphy.com.872 > residue.holomorphy.com.1023: udp 56 (DF)
11:47:22.049144 residue.holomorphy.com.1023 > meromorphy.holomorphy.com.sunrpc: udp 76
11:47:22.049495 meromorphy.holomorphy.com.sunrpc > residue.holomorphy.com.1023: udp 28 (DF)
11:47:22.053544 residue.holomorphy.com.1 > meromorphy.holomorphy.com.nfs: 80 getattr [|nfs]
11:47:22.071076 singularity.holomorphy.com.nfs > residue.holomorphy.com.1: reply ok 112 (DF)
11:47:22.072941 residue.holomorphy.com.2 > meromorphy.holomorphy.com.nfs: 76 fsinfo [|nfs]
11:47:22.073960 meromorphy.holomorphy.com.nfs > residue.holomorphy.com.2: reply ok 80 fsinfo [|nfs] (DF)
11:47:22.075786 residue.holomorphy.com.3 > meromorphy.holomorphy.com.nfs: 96 readdir [|nfs]
11:47:22.079182 meromorphy.holomorphy.com.nfs > residue.holomorphy.com.3: reply ok 864 readdir (DF)
11:47:22.262862 arp who-has meromorphy.holomorphy.com tell residue.holomorphy.com
11:47:22.262896 arp reply meromorphy.holomorphy.com is-at 0:20:78:1e:2b:94
11:47:22.263523 residue.holomorphy.com.1226993665 > meromorphy.holomorphy.com.nfs: 88 lookup [|nfs]
11:47:22.263781 meromorphy.holomorphy.com.nfs > residue.holomorphy.com.1226993665: reply ok 228 lookup fh Unknown/1 [|nfs] (DF)
11:47:22.266192 residue.holomorphy.com.1226993666 > meromorphy.holomorphy.com.nfs: 100 lookup [|nfs]
11:47:22.266439 meromorphy.holomorphy.com.nfs > residue.holomorphy.com.1226993666: reply ok 236 lookup [|nfs] (DF)
11:47:22.343164 residue.holomorphy.com.1226993667 > meromorphy.holomorphy.com.nfs: 88 lookup [|nfs]
11:47:22.343444 meromorphy.holomorphy.com.nfs > residue.holomorphy.com.1226993667: reply ok 228 lookup fh Unknown/1 [|nfs] (DF)
11:47:22.345650 residue.holomorphy.com.1226993668 > meromorphy.holomorphy.com.nfs: 96 lookup [|nfs]
11:47:22.348087 meromorphy.holomorphy.com.nfs > residue.holomorphy.com.1226993668: reply ok 236 lookup [|nfs] (DF)
11:47:22.350323 residue.holomorphy.com.1226993669 > meromorphy.holomorphy.com.nfs: 100 access [|nfs]
11:47:22.350575 meromorphy.holomorphy.com.nfs > residue.holomorphy.com.1226993669: reply ok 120 access c 0000 (DF)
11:47:22.352427 residue.holomorphy.com.1226993670 > meromorphy.holomorphy.com.nfs: 96 getattr [|nfs]
11:47:22.352613 meromorphy.holomorphy.com.nfs > residue.holomorphy.com.1226993670: reply ok 112 getattr REG 100555 ids 0/0 [|nfs] (DF)
11:47:22.354458 residue.holomorphy.com.1226993671 > meromorphy.holomorphy.com.nfs: 108 read [|nfs]
11:47:22.355157 meromorphy.holomorphy.com.nfs > residue.holomorphy.com.1226993671: reply ok 1472 read (frag 7668:1480@0+)
11:47:22.355179 meromorphy.holomorphy.com > residue.holomorphy.com: udp (frag 7668:1480@1480+)
11:47:22.355195 meromorphy.holomorphy.com > residue.holomorphy.com: udp (frag 7668:1480@2960+)
11:47:22.355213 meromorphy.holomorphy.com > residue.holomorphy.com: udp (frag 7668:1480@4440+)
11:47:22.355229 meromorphy.holomorphy.com > residue.holomorphy.com: udp (frag 7668:1480@5920+)
11:47:22.355244 meromorphy.holomorphy.com > residue.holomorphy.com: udp (frag 7668:928@7400)
11:47:27.980197 residue.holomorphy.com.1226993671 > meromorphy.holomorphy.com.nfs: 108 read [|nfs]
11:47:27.980535 meromorphy.holomorphy.com.nfs > residue.holomorphy.com.1226993671: reply ok 1472 read (frag 7669:1480@0+)
11:47:27.980558 meromorphy.holomorphy.com > residue.holomorphy.com: udp (frag 7669:1480@1480+)
11:47:27.980577 meromorphy.holomorphy.com > residue.holomorphy.com: udp (frag 7669:1480@2960+)
11:47:27.980594 meromorphy.holomorphy.com > residue.holomorphy.com: udp (frag 7669:1480@4440+)
11:47:27.980633 meromorphy.holomorphy.com > residue.holomorphy.com: udp (frag 7669:1480@5920+)
11:47:27.980648 meromorphy.holomorphy.com > residue.holomorphy.com: udp (frag 7669:928@7400)
11:47:39.230272 residue.holomorphy.com.1226993671 > meromorphy.holomorphy.com.nfs: 108 read [|nfs]
11:47:39.230624 meromorphy.holomorphy.com.nfs > residue.holomorphy.com.1226993671: reply ok 1472 read (frag 7670:1480@0+)
11:47:39.230646 meromorphy.holomorphy.com > residue.holomorphy.com: udp (frag 7670:1480@1480+)
11:47:39.230666 meromorphy.holomorphy.com > residue.holomorphy.com: udp (frag 7670:1480@2960+)
11:47:39.230682 meromorphy.holomorphy.com > residue.holomorphy.com: udp (frag 7670:1480@4440+)
11:47:39.230698 meromorphy.holomorphy.com > residue.holomorphy.com: udp (frag 7670:1480@5920+)
11:47:39.230712 meromorphy.holomorphy.com > residue.holomorphy.com: udp (frag 7670:928@7400)
11:48:01.722653 residue.holomorphy.com.1226993671 > meromorphy.holomorphy.com.nfs: 108 read [|nfs]
11:48:01.723020 meromorphy.holomorphy.com.nfs > residue.holomorphy.com.1226993671: reply ok 1472 read (frag 7671:1480@0+)
11:48:01.723043 meromorphy.holomorphy.com > residue.holomorphy.com: udp (frag 7671:1480@1480+)
11:48:01.723062 meromorphy.holomorphy.com > residue.holomorphy.com: udp (frag 7671:1480@2960+)
11:48:01.723079 meromorphy.holomorphy.com > residue.holomorphy.com: udp (frag 7671:1480@4440+)
11:48:01.723096 meromorphy.holomorphy.com > residue.holomorphy.com: udp (frag 7671:1480@5920+)
11:48:01.723111 meromorphy.holomorphy.com > residue.holomorphy.com: udp (frag 7671:928@7400)
