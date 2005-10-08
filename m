Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVJHF7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVJHF7w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 01:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVJHF7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 01:59:51 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:64741 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750702AbVJHF7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 01:59:51 -0400
Subject: Re: why is NFS performance poor when decompress linux kernel
From: Lee Revell <rlrevell@joe-job.com>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4ae3c140510072139n68b9b2eeyc0a400be32d958fe@mail.gmail.com>
References: <4ae3c140510072139n68b9b2eeyc0a400be32d958fe@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 08 Oct 2005 01:59:48 -0400
Message-Id: <1128751189.17981.62.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-10-08 at 00:39 -0400, Xin Zhao wrote:
> I noticed that when doing large file copy or linux kernel compilation
> in a NFS direcotry, the performance is not bad compared to local disk
> filesystem such as ext2. However, if I do linux kernel tarball
> decompression on a NFS directory, the performance is much worse than
> local disk filesystem (over 3 times slower). Anybody know the reason?

Because NFS requires all writes to be synchronous by default, and
uncompressing the kernel is the most write intensive of those three
operations.  Mount with the async option and the performance should be
closer to a local disk.  Obviously this is more dangerous.

Lee

