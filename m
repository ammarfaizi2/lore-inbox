Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262711AbSI1EmP>; Sat, 28 Sep 2002 00:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262714AbSI1Eke>; Sat, 28 Sep 2002 00:40:34 -0400
Received: from ns.commfireservices.com ([216.6.9.162]:46862 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id <S262711AbSI1EbQ>; Sat, 28 Sep 2002 00:31:16 -0400
Date: Sat, 28 Sep 2002 00:35:30 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.38-mm3
In-Reply-To: <20020927152833.D25021@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0209280034101.32347-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2002, Dipankar Sarma wrote:

> The counts are off by one.
> 
> With a UP kernel, I see that fget() cost is negligible.
> So it is most likely the atomic operations for rwlock acquisition/release
> in fget() that is adding to its cost. Unless of course my sampling
> is too less.

Mine is a UP box not an SMP kernel, although preempt is enabled;

0xc013d370 <fget>:      push   %ebx
0xc013d371 <fget+1>:    mov    %eax,%ecx
0xc013d373 <fget+3>:    mov    $0xffffe000,%edx
0xc013d378 <fget+8>:    and    %esp,%edx
0xc013d37a <fget+10>:   incl   0x4(%edx)
0xc013d37d <fget+13>:   xor    %ebx,%ebx
0xc013d37f <fget+15>:   mov    0x554(%edx),%eax
0xc013d385 <fget+21>:   cmp    0x8(%eax),%ecx
0xc013d388 <fget+24>:   jae    0xc013d390 <fget+32>
0xc013d38a <fget+26>:   mov    0x14(%eax),%eax
0xc013d38d <fget+29>:   mov    (%eax,%ecx,4),%ebx
0xc013d390 <fget+32>:   test   %ebx,%ebx
0xc013d392 <fget+34>:   je     0xc013d397 <fget+39>
0xc013d394 <fget+36>:   incl   0x14(%ebx)
0xc013d397 <fget+39>:   decl   0x4(%edx)
0xc013d39a <fget+42>:   mov    0x14(%edx),%eax
0xc013d39d <fget+45>:   cmp    %eax,0x4(%edx)
0xc013d3a0 <fget+48>:   jge    0xc013d3a7 <fget+55>
0xc013d3a2 <fget+50>:   call   0xc01179b0 <preempt_schedule>
0xc013d3a7 <fget+55>:   mov    %ebx,%eax
0xc013d3a9 <fget+57>:   pop    %ebx
0xc013d3aa <fget+58>:   ret
0xc013d3ab <fget+59>:   nop
0xc013d3ac <fget+60>:   lea    0x0(%esi,1),%esi

> Please try running the files_struct_rcu patch where fget() is lockfree
> and let me know what you see.

Lock acquisition/release should be painless on this system no?

	Zwane
-- 
function.linuxpower.ca

