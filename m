Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267107AbTBUEPo>; Thu, 20 Feb 2003 23:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267123AbTBUEPo>; Thu, 20 Feb 2003 23:15:44 -0500
Received: from 5-077.ctame701-1.telepar.net.br ([200.193.163.77]:16609 "EHLO
	5-077.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267107AbTBUEPn>; Thu, 20 Feb 2003 23:15:43 -0500
Date: Fri, 21 Feb 2003 01:25:25 -0300 (BRT)
From: Rik van Riel <riel@imladris.surriel.com>
To: Andrew Morton <akpm@digeo.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, "" <linux-kernel@vger.kernel.org>,
       "" <lse-tech@lists.sourceforge.net>, "" <dmccr@us.ibm.com>
Subject: Re: Performance of partial object-based rmap
In-Reply-To: <20030220194759.15d5d932.akpm@digeo.com>
Message-ID: <Pine.LNX.4.50L.0302210117490.2329-100000@imladris.surriel.com>
References: <7490000.1045715152@[10.10.2.4]> <278890000.1045791857@flay>
 <20030220190819.531e119d.akpm@digeo.com> <Pine.LNX.4.50L.0302210020560.2329-100000@imladris.surriel.com>
 <20030220194759.15d5d932.akpm@digeo.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2003, Andrew Morton wrote:

> We see things like the below report, which realistically shows
> the problems with the reverse map.

Indeed, these need to be fixed.

> I have yet to see _any_ report that the problems to which you refer
> are causing difficulty in the field.

Well, Dave's patch has only been out for a day ;))

> I think there's a middle ground.  Hint: MAP_ORACLE.

I think Dave's current patch could be a good start.  In many
cases where object based mapping hurts, the system would use
nonlinear VMAs anyawy.

This means we can probably get away with using Dave's object
based rmaps in the areas where they are currently supported,
while using page based rmaps for anonymous memory and nonlinear
vmas.

For object-based reverse mapping, the worst case is with large
objects which are sparsely mapped many times (nonlinear vmas)
and deeply inherited COW anonymous memory (apache w/ 300 children).

For pte chains, the worst case is with heavily shared mostly read
only areas (shared libraries) or heavily shared and used shared
memory segments.

The hybrid scheme in Dave's patch looks like it uses the right
code in the right situation, avoiding these worst cases by using
the other reverse mapping scheme.

The more I think about it, the more I think there are reasons
we might want to stick to a hybrid scheme forever...

regards,

Rik
-- 
Engineers don't grow up, they grow sideways.
http://www.surriel.com/		http://kernelnewbies.org/
