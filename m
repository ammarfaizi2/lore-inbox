Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262536AbSJPOBJ>; Wed, 16 Oct 2002 10:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264845AbSJPOBJ>; Wed, 16 Oct 2002 10:01:09 -0400
Received: from zero.aec.at ([193.170.194.10]:51206 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S262536AbSJPOBI>;
	Wed, 16 Oct 2002 10:01:08 -0400
Date: Wed, 16 Oct 2002 16:06:58 +0200
From: Andi Kleen <ak@muc.de>
To: linux-kernel@vger.kernel.org, peter@chubb.wattle.id.au
Subject: statfs64 missing
Message-ID: <20021016140658.GA8461@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I notice 2.5 has 64bit sector_t but no statfs64() system call for 32bit
architectures. How is df supposed to report it? statfs uses 32bit
block counts.

The currently limit depends on the block size, the bigger your block
size the more bytes it can report.

This problem already exists on 2.4. You can actually access NFS servers
which have more than 2TB of disk space. NFS uses the local write size
as block size. When you are lucky then 0xfffffffff*wsize is bigger 
than what your NFS server reports. If not you get wrong results.
The only workaround currently is to increase wsize, but that has its
limits too.

Fixing it properly probably requires statfs64(). Any reason why this 
was not included in the sector_t patchkit ? 

-Andi
