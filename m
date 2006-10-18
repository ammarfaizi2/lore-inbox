Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161231AbWJRRoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161231AbWJRRoc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161246AbWJRRoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:44:32 -0400
Received: from mx0.karneval.cz ([81.27.192.123]:14658 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S1161231AbWJRRob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:44:31 -0400
Message-ID: <453667F1.4040504@gmail.com>
Date: Wed, 18 Oct 2006 19:44:17 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Sven Hoexter <shoexter@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] nfs client: Read-only file system (2.6.19-rc1,2)
References: <4534F59D.4040505@gmail.com>	 <1161104051.5559.5.camel@lade.trondhjem.org> <eh4hhb$sp7$1@sea.gmane.org>	 <4535EB4F.4070406@gmail.com>  <45364C51.2000004@gmail.com> <1161192121.6095.58.camel@lade.trondhjem.org>
In-Reply-To: <1161192121.6095.58.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> I'll bet that you have always had a subdirectory of the exact same
> filesystem mounted somewhere else ro, right?

Yup, exactly: /usr -ro and /home -rw on the same (hda3) partition.

> The new NFS mount code will put those in the same superblock, and
> whichever directory gets mounted first will determine whether or not the
> superblock is marked as read-only.
> Basically, NFS is now doing the exact same thing that local filesystems
> have been doing all the time: if it is on the same disk, then it is all
> represented by the same superblock. OTOH, if your server is exporting
> more than one partition, then different partitions will be represented
> by different superblocks.
> We need to do this for the same reason that local filesystems do it: it
> is the only way to ensure cache consistency. Otherwise, if you make
> changes to a file that happens to be mounted in more than one place,
> then you will see inconsistent results on the other mountpoints.

thanks for clarification,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
