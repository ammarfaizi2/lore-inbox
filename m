Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267602AbTAXImN>; Fri, 24 Jan 2003 03:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267605AbTAXImN>; Fri, 24 Jan 2003 03:42:13 -0500
Received: from holomorphy.com ([66.224.33.161]:57753 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267602AbTAXImM>;
	Fri, 24 Jan 2003 03:42:12 -0500
Date: Fri, 24 Jan 2003 00:50:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: GrandMasterLee <masterlee@digitalroadkill.net>,
       Austin Gonyou <austin@coremetrics.com>, linux-kernel@vger.kernel.org
Subject: Re: Using O(1) scheduler with 600 processes.
Message-ID: <20030124085026.GW780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	GrandMasterLee <masterlee@digitalroadkill.net>,
	Austin Gonyou <austin@coremetrics.com>,
	linux-kernel@vger.kernel.org
References: <1043367029.28748.130.camel@UberGeek> <310350000.1043367864@titus> <1043388556.12894.23.camel@localhost> <435060000.1043389112@titus> <1043389673.14486.7.camel@localhost> <438270000.1043390898@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438270000.1043390898@titus>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, someone else wrote:
>> So I decided to try 2.4.20aa1 instead, reversing the xfs patches, and
>> then updating with a newer code base, worse problems reversing those xfs
>> patches. 
>> SO I decided to just roll my own with the known features we use in
>> production.
>> 2.4.20 + xfs + lvm106 + rmap or aavm + O(1) sched + pte-highmem. 

On Thu, Jan 23, 2003 at 10:48:19PM -0800, Martin J. Bligh wrote:
> If you have enough ptes to want pte-highmem, I doubt you want rmap.
> pte-chain space consumption will kill you. The calculations are pretty
> easy to work out as to what the right solution is for your setup.

Basically vma-based ptov resolution needs to be implemented for private
anonymous pages, which will require much less ZONE_NORMAL space overhead
as pte_chains may then be chucked.

Dropping physical scanning altogether would be a mistake esp. for boxen
of any appreciable amount of physical locality (NUMA, big highmem
penalties, etc.) or wishing to support any significant number of tasks.


-- wli
