Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262112AbSIYUzz>; Wed, 25 Sep 2002 16:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262114AbSIYUzz>; Wed, 25 Sep 2002 16:55:55 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:57033 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262112AbSIYUzy>; Wed, 25 Sep 2002 16:55:54 -0400
Date: Wed, 25 Sep 2002 13:57:22 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Theurer <habanero@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.38-mm2 dbench $N times
Message-ID: <253480000.1032987442@flay>
In-Reply-To: <200209251351.58355.habanero@us.ibm.com>
References: <3D9103EB.FC13A744@digeo.com> <297318451.1032908628@[10.10.2.3]> <200209251351.58355.habanero@us.ibm.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Pretty sure each dbench child does it's own write/read to only it's own data.  
> There is no sharing that I am aware of between the processes.  

Right, but if the processes migrate easily, there's still no CPU locality.
Bill, do you want to try binding 1/32 of the processes to each CPU, and see if
that makes your throughput increase?

> How about running in tmpfs to avoid any disk IO at all?  

As far as I understand it, that won't help - we're operating out of pagecache anyway 
at this level, I think.
 
> Also, what's the policy for home node assignment on fork?  Are all of these 
> children getting the same home node assingnment??

Policy is random - the scheduler lacks any NUMA comprehension at the moment.
The numa sched mods would probably help a lot too.

M.

