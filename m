Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287710AbSBCUXP>; Sun, 3 Feb 2002 15:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287720AbSBCUXF>; Sun, 3 Feb 2002 15:23:05 -0500
Received: from mx2.elte.hu ([157.181.151.9]:36581 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S287710AbSBCUWx>;
	Sun, 3 Feb 2002 15:22:53 -0500
Date: Sun, 3 Feb 2002 21:22:51 +0100
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.4.17 NFS hangup
Message-ID: <20020203202251.GA22797@csoma.elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Accept-Language: en, hu
From: "Burjan Gabor" <buga+dated+1013026971.2270df@elte.hu>
X-Delivery-Agent: TMDA/0.43 (Python 2.1.1+; linux2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a reproducable problem with 2.4.17 kernel and NFS client after
netbooting an RS/6000 (ppc architecture).

Immediately after boot:

partvis:/tmp# dd if=/dev/zero of=blah1 count=1
1+0 records in
1+0 records out
partvis:/tmp#

partvis:/tmp# dd if=/dev/zero of=blah2 count=2
2+0 records in
2+0 records out
nfs: server 157.181.150.31 not responding, still trying
nfs: server 157.181.150.31 not responding, still trying
nfs: task 913 can't get a request slot
... and so on

Relevant tcpdump output:

20:41:40.927855 heron.elte.hu.nfs > partvis.elte.hu.3648238371: reply ok 28 lookup ERROR: No such file or directory (DF)
20:41:40.928622 partvis.elte.hu.3648238372 > heron.elte.hu.nfs: 148 create [|nfs] (DF)
20:41:40.929271 heron.elte.hu.nfs > partvis.elte.hu.3648238372: reply ok 128 create [|nfs] (DF)
20:41:40.930655 partvis.elte.hu.3648238373 > heron.elte.hu.nfs: 100 getattr [|nfs] (DF)
20:41:40.930976 heron.elte.hu.nfs > partvis.elte.hu.3648238373: reply ok 96 getattr REG 100644 ids 0

However, reading works without any problems.  Full tcpdump output from
poweron: http://www.csoma.elte.hu/~burjang/nfs-tcpdump-20010203.out.gz

	buga
