Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319089AbSHFNnJ>; Tue, 6 Aug 2002 09:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319088AbSHFNnJ>; Tue, 6 Aug 2002 09:43:09 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:53221 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S319089AbSHFNnI>; Tue, 6 Aug 2002 09:43:08 -0400
Date: Tue, 6 Aug 2002 14:47:14 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Duc Vianney <dvianney@us.ibm.com>
cc: linux-kernel@vger.kernel.org, <lse-tech@lists.sourceforge.net>,
       <mcao@us.ibm.com>, <bhartner@us.ibm.com>
Subject: Re: IPC lock patch performance improvement
In-Reply-To: <3D4F0403.B136A031@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0208061436280.1441-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2002, Duc Vianney wrote:
> I ran the LMbench Pipe and IPC latency test bucket against the IPC lock
> patch from Mingming Cao and found the patch improves the performance of
> those functions from 1% to 9%. See the attached data. The kernel under
> test is 2.5.29, SMP kernel running on a 4-way 500 MHz. The data for
> 2.5.29s4-ipc represents the average of three runs.
> 
>                                                            Percent
>                                   2.5.29s4 2.5.29s4-ipc Improvement
> Pipe latency                         12.51     11.43         9%
> AF_Unix sock stream latency          21.61     19.82         8%
> UDP latency using localhost          36.28     35.12         3%
> TCP latency using localhost          56.90     54.89         4%
> RPC/tcp latency using local host    123.30    121.91         1%
> RPC/udp latency using localhost      89.78     88.70         1%
> TCP/IP connection cost to localhost 192.74    187.76         3%
> Note: Latency is in microseconds
> Note: 2.5.29s4 is the base 2.5.29 SMP kernel running on a 4-way,
> 2.5.29s4-ipc is the base 2.5.29 SMP kernel built with IPC lock patch.

Please show me I'm wrong, but so far as I can see (from source and
breakpoints) LMbench never touches the SysV IPC code, which is the only
code affected by Mingming's proposed IPC locking changes.  I believe
LMbench tests InterProcessCommunication via pipes and sockets,
not via the SysV IPC msg sem and shm.

If that's right, then your improvement is magical; but we can
hope for even better when the appropriate codepaths are tested.

Hugh

