Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268697AbTCCR3j>; Mon, 3 Mar 2003 12:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268698AbTCCR3j>; Mon, 3 Mar 2003 12:29:39 -0500
Received: from franka.aracnet.com ([216.99.193.44]:41415 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268697AbTCCR3h>; Mon, 3 Mar 2003 12:29:37 -0500
Date: Mon, 03 Mar 2003 09:40:01 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: percpu-2.5.63-bk5-1 (properly generated)
Message-ID: <29220000.1046713200@[10.10.2.4]>
In-Reply-To: <20030303014320.GM1195@holomorphy.com>
References: <47970000.1046629477@[10.10.2.4]> <20030302202451.GJ1195@holomorphy.com> <50380000.1046637959@[10.10.2.4]> <20030302210606.GS24172@holomorphy.com> <85980000.1046642338@[10.10.2.4]> <20030302221037.GK1195@holomorphy.com> <87420000.1046646801@[10.10.2.4]> <20030302234252.GL1195@holomorphy.com> <88060000.1046650020@[10.10.2.4]> <20030303014320.GM1195@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sun, Mar 02, 2003 at 04:07:01PM -0800, Martin J. Bligh wrote:
>> Failing that, if you can split it into 3 or 4 patches along the lines I
>> suggested earlier, I'll try benching each bit seperately for you.
> 
> Last ditch effort. No per_node stuff at all, and no new per_cpu users.
 

OK, that seems to get rid of the SDET degradation, but I rigged up the
same test you were doing (make -j) and see only marginal improvement
from the full patch (pernode2) ... not the 6s you were seeing.

Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed      System        User         CPU
              2.5.63-mjb2       44.09       94.38      557.26     1477.00
     2.5.63-mjb2-pernode2       44.54       96.38      557.30     1466.75
     2.5.63-mjb2-pernode3       44.01       95.22      556.69     1481.25

Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed      System        User         CPU
              2.5.63-mjb2       45.53      118.06      560.48     1489.50
     2.5.63-mjb2-pernode2       45.25      116.68      561.28     1497.50
     2.5.63-mjb2-pernode3       45.30      116.91      559.82     1492.00

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
              2.5.63-mjb2       45.17      117.80      560.62     1500.50
     2.5.63-mjb2-pernode2       44.91      115.95      560.98     1505.25
     2.5.63-mjb2-pernode3       45.47      118.07      560.25     1491.75


-pernode2 was your full patch with the fix you sent, -pernode3 was the 
smaller patch you sent last. Can you try to reproduce the improvment
were seeing, and grab a before and after profile? I don't seem to be 
able to replicate it.

M.

