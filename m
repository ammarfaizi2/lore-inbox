Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268831AbTBZVGG>; Wed, 26 Feb 2003 16:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268832AbTBZVGG>; Wed, 26 Feb 2003 16:06:06 -0500
Received: from franka.aracnet.com ([216.99.193.44]:51591 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268831AbTBZVGF>; Wed, 26 Feb 2003 16:06:05 -0500
Date: Wed, 26 Feb 2003 13:16:15 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andi Kleen <ak@suse.de>
cc: lse-tech@projects.sourceforge.net, akpm@digeo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [PATCH] New dcache / inode hash tuning patch
Message-ID: <6000000.1046294173@[10.10.2.4]>
In-Reply-To: <20030226183304.GA30836@wotan.suse.de>
References: <20030226164904.GA21342@wotan.suse.de>
 <15730000.1046283789@[10.10.2.4]> <20030226183304.GA30836@wotan.suse.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It actually seems a fraction slower (see systimes for Kernbench-16,
>> for instance).
> 
> Can you play a bit with the hash table sizes? Perhaps double the 
> dcache hash and half the inode hash ?

I quadrupled the dcache hash size ... helped a bit. Is still a little
slower, which I don't understand ... your plan should make it go faster,
AFAICS. Those off-node accesses to ZONE_NORMAL are really expensive for me.

Kernbench-2: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed        User      System         CPU
              2.5.62-mjb3       44.24      558.12       94.17     1473.83
         2.5.62-mjb3-andi       44.28      557.90       95.79     1475.67
      2.5.62-mjb3-andi-4x       44.20      557.96       94.77     1475.83

Kernbench-16: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed        User      System         CPU
              2.5.62-mjb3       45.19      560.95      114.77     1495.00
         2.5.62-mjb3-andi       45.39      561.29      117.73     1495.67
      2.5.62-mjb3-andi-4x       45.34      560.54      116.85     1493.50

> I suspect it really just needs a better hash function. I'll cook
> something up based on FNV hash.

Sounds good ;-)

M.

