Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313486AbSDPCVB>; Mon, 15 Apr 2002 22:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313492AbSDPCVB>; Mon, 15 Apr 2002 22:21:01 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:39698 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S313486AbSDPCVA>;
	Mon, 15 Apr 2002 22:21:00 -0400
Date: Tue, 16 Apr 2002 11:20:24 +0900 (JST)
Message-Id: <20020416.112024.96917545.taka@valinux.co.jp>
To: jakob@unthought.net
Cc: davem@redhat.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20020416034120.R18116@unthought.net>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

jakob> Won't this serialize too much ?  I mean, consider the situation where we
jakob> have file-A and file-B completely in cache, while file-C needs to be
jakob> read from the physical disk.
jakob> 
jakob> Three different clients (A, B and C) request file-A, file-B and file-C
jakob> respectively. The send of file-C is started first, and the sends of files
jakob> A and B (which could commence immediately and complete at near wire-speed)
jakob> will now have to wait (leaving the NIC idle) until file-C is read from
jakob> the disks.
jakob> 
jakob> Even if it's not the entire file but only a single NFS request (probably 8kB),
jakob> one disk seek (7ms) is still around 85 kB, or 10 8kB NFS requests (at 100Mbit).
jakob> 
jakob> Or am I misunderstanding ?   Will your UDP sendpage() queue the requests ?

No problem.
On my implementation, at the beginning a knfsd grabs all pages -- a part
of file-C -- to reply to the NFS client. After that the knfsd starts to
send them. It won't block any other knfsds during disk I/Os.

Thank you,
Hirokazu Takahashi.

