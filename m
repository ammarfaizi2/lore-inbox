Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292751AbSCDSu2>; Mon, 4 Mar 2002 13:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292728AbSCDStB>; Mon, 4 Mar 2002 13:49:01 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:57506 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292733AbSCDSsu>; Mon, 4 Mar 2002 13:48:50 -0500
Date: Mon, 04 Mar 2002 10:46:54 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: riel@conectiva.com.br, andrea@suse.de, phillips@bonn-fries.net,
        davidsen@tmr.com, mfedyk@matchmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <203430000.1015267614@flay>
In-Reply-To: <20020304191804.2e58761c.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44L.0203041116120.2181-100000@imladris.surriel.com><190330000.1015261149@flay> <20020304191804.2e58761c.skraw@ithnet.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 2) We can do local per-node scanning - no need to bounce
>> information to and fro across the interconnect just to see what's
>> worth swapping out.
> 
> Well, you can achieve this by "attaching" the nodes' local memory 
> (zone) to its cpu and let the vm work preferably only on these attached 
> zones (regarding the list scanning and the like). This way you have no 
> interconnect traffic generated. But this is in no way related to rmap.
>
>> I can't see any way to fix this without some sort of rmap - any
>> other suggestions as to how this might be done?
> 
> As stated above: try to bring in per-node zones that are preferred by their cpu. This can work equally well for UP,SMP and NUMA (maybe even for cluster).
> UP=every zone is one or more preferred zone(s)
> SMP=every zone is one or more preferred zone(s)
> NUMA=every cpu has one or more preferred zone(s), but can walk the whole zone-list if necessary.
>
> Preference is implemented as simple list of cpu-ids attached to every 
> memory zone.  This is for being able to see the whole picture. Every 
> cpu has a private list of (preferred) zones which is used by vm for the 
> scanning jobs (swap et al). This way there is no need to touch interconnection. 
> If you are really in a bad situation you can alway go back to the global 
> list and do whatever is needed.

As I understand the current code (ie this may be totally wrong ;-) ) I think 
we already pretty much have what you're suggesting. There's one (or more) 
zone per node chained off the pgdata_t, and during memory allocation we 
try to scan through the zones attatched to the local node first. The problem 
seems to me to be that the way we do current swap-out scanning is virtual, 
not physical, and thus cannot be per zone => per node.

Am I totally missing your point here?

Thanks,

Martin.



