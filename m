Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293342AbSCEPcW>; Tue, 5 Mar 2002 10:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293351AbSCEPcK>; Tue, 5 Mar 2002 10:32:10 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:1951 "EHLO mail3.aracnet.com")
	by vger.kernel.org with ESMTP id <S293349AbSCEPbw>;
	Tue, 5 Mar 2002 10:31:52 -0500
Date: Tue, 05 Mar 2002 07:29:11 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Rik van Riel <riel@conectiva.com.br>, Andrea Arcangeli <andrea@suse.de>
cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <830115452.1015313350@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.44L.0203050921510.1413-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.44L.0203050921510.1413-100000@duckman.distro.conecti
 va>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, March 05, 2002 9:22 AM -0300 Rik van Riel 
<riel@conectiva.com.br> wrote:

> On Tue, 5 Mar 2002, Andrea Arcangeli wrote:
>> On Mon, Mar 04, 2002 at 10:26:30PM -0300, Rik van Riel wrote:
>> > On Tue, 5 Mar 2002, Andrea Arcangeli wrote:
>> > > On Mon, Mar 04, 2002 at 09:01:31PM -0300, Rik van Riel wrote:
>> > > > This could be expressed as:
>> > > >
>> > > > "node A"  HIGHMEM A -> HIGHMEM B -> NORMAL -> DMA
>> > > > "node B"  HIGHMEM B -> HIGHMEM A -> NORMAL -> DMA
>
>> the example you made doesn't have highmem at all.
>>
>> > has 1 ZONE_NORMAL and 1 ZONE_DMA while it has multiple
>> > HIGHMEM zones...
>>
>> it has multiple zone normal and only one zone dma. I'm not forgetting
>> that.
>
> Your reality doesn't seem to correspond well with NUMA-Q
> reality.

I think the difference is that he has a 64 bit vaddr space,
and I don't ;-) Thus all mem to him is ZONE_NORMAL (not sure
why he still has a ZONE_DMA, unless he reused it for the 4Gb
boundary). Andrea, is my assumtpion correct?

On a 32 bit arch (eg ia32) everything above 896Mb (by default)
is ZONE_HIGHMEM. Thus if I have > 896Mb in the first node,
I will have one ZONE_NORMAL in node 0, and a ZONE_HIGHMEM
in every node. If I have < 896Mb in the first node, then
I have a ZONE_NORMAL in every node up to and including the
896 breakpoint, and a ZONE_HIGHMEM in every node from the
breakpoint up (including the breakpoint node). Thus the number
of zones = number of nodes + 1.

M.

