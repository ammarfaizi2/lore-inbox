Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271212AbRIFPQH>; Thu, 6 Sep 2001 11:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271226AbRIFPP5>; Thu, 6 Sep 2001 11:15:57 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:14257 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271212AbRIFPPr>;
	Thu, 6 Sep 2001 11:15:47 -0400
Date: Thu, 06 Sep 2001 16:16:05 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Rik van Riel <riel@conectiva.com.br>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, phillips@bonn-fries.net,
        jaharkes@cs.cmu.edu, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: page_launder() on 2.4.9/10 issue
Message-ID: <598875357.999792965@[10.132.112.53]>
In-Reply-To: <Pine.LNX.4.33L.0109061206020.31200-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0109061206020.31200-100000@imladris.rielhome.con
 ectiva>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Thursday, September 06, 2001 12:07 PM -0300 Rik van Riel 
<riel@conectiva.com.br> wrote:

> On many systems, higher-order allocations are a really really
> small fraction of the allocations, so ideally we'd have them
> take the burden of memory fragmentation and won't punish the
> normal allocations.

The only nit being, every instance Stephan's reported so far,
and in most other reports I've seen, the allocation
has been GFP_ATOMIC (i.e. with mask without __GFP_WAIT).
For non-atomic >0 order allocations we already have some
good logic that does (b) via page_launder(), and
where necessary reclaim_page(),__free_page().

So waiting until we are in the high order allocation
allocation is too late, as we don't have room to move.

I think we need to defragment / avoid fragmentation
BEFORE the GFP_ATOMIC high order allocation comes along.
I have some ideas I'd like to test tonight.

--
Alex Bligh
