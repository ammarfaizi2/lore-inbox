Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265988AbRF1PXf>; Thu, 28 Jun 2001 11:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265989AbRF1PXQ>; Thu, 28 Jun 2001 11:23:16 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:57845 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S265988AbRF1PXM>; Thu, 28 Jun 2001 11:23:12 -0400
Mime-Version: 1.0
Message-Id: <a05100301b760fb217ddc@[192.168.239.101]>
In-Reply-To: <01062816393503.00419@starship>
In-Reply-To: <OF95A43E53.39291B42-ON84256A79.003D421D@urscorp.com>
 <01062816393503.00419@starship>
Date: Thu, 28 Jun 2001 16:21:58 +0100
To: Daniel Phillips <phillips@bonn-fries.net>, mike_phillips@urscorp.com,
        <linux-kernel@vger.kernel.org>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: VM Requirement Document - v0.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>There is a simple change in strategy that will fix up the updatedb case quite
>nicely, it goes something like this: a single access to a page (e.g., reading
>it) isn't enough to bring it to the front of the LRU queue, but accessing it
>twice or more is.  This is being looked at.

Say, when a page is created due to a page fault, page->age is set to 
zero instead of whatever it is now.  Then, on the first access, it is 
incremented to one.  All accesses where page->age was previously zero 
cause it to be incremented to one, and subsequent accesses where 
page->age is non-zero cause a doubling rather than an increment. 
This gives a nice heavy priority boost to frequently-accessed pages...

>Note that we don't actually use a LRU queue, we use a more efficient
>approximation called aging, so the above is not a recipe for implementation.

Maybe it is, but in a slightly lateral manner as above.

-- 
--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
website:  http://www.chromatix.uklinux.net/vnc/
geekcode: GCS$/E dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$
           V? PS PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
tagline:  The key to knowledge is not to rely on people to teach you it.
