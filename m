Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310283AbSCGLtj>; Thu, 7 Mar 2002 06:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310204AbSCGLta>; Thu, 7 Mar 2002 06:49:30 -0500
Received: from ns.caldera.de ([212.34.180.1]:28329 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S310285AbSCGLtW>;
	Thu, 7 Mar 2002 06:49:22 -0500
Date: Thu, 7 Mar 2002 12:48:39 +0100
Message-Id: <200203071148.g27BmdP16433@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: cmm@us.ibm.com (mingming cao)
Cc: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Rework of /proc/stat
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <3C86BEB0.4090203@us.ibm.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C86BEB0.4090203@us.ibm.com> you wrote:
>> Any reason for preferring this over the sard patches in -ac ?
>> 
> Basically, statistic data are moved from the global kstat structure

Why do you think sard uses kstat?

> to 
> the request_queue structures, and it is allocated/freed when the request 
> queue is initialized and freed.  This way it is

> 1)self-controlled;
> 2)avoid the lookup step before the accounting, so it should be faster;

in 2.4.18+ get_gendisk is O(1) - the lookup is not costly at all.

> 3)statistics implementation is not affected by the major/minor numbers;

Gendisks currently are per-major, which is a disadvantage, but the sard
code itself is not affected by that.

> 4)able to gathering statistics for all disks while keep the memory needs 
> minimized.

The same is true for sard.

Somehow I think you haven't actually looked at the sard code in -ac..

