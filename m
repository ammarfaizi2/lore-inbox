Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbTJAHTZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 03:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbTJAHTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 03:19:25 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:49137 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id S261976AbTJAHTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 03:19:15 -0400
Date: Wed, 1 Oct 2003 03:19:05 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6 scheduling(?) oddness
Message-ID: <20031001071905.GG1416@Master>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20031001032238.GB1416@Master> <20030930215512.1df59be3.akpm@osdl.org> <3F7A604F.1060905@cyberone.com.au> <20031001051827.GE1416@Master> <20030930235317.1d293a71.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930235317.1d293a71.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 11:53:17PM -0700, Andrew Morton wrote:
> "Murray J. Root" <murrayr@brain.org> wrote:
> >
> 
>  (the linux-kernel email convention is "reply to all", btw)
>  
> >  test6 goes from 30 mins to 24 mins - still worse than test5 by a lot.
> 
> What sort of context switch rate are you seeing during this run?  Running
> `vmstat 1' will tell.

I have no idea how to read it, but the lines look like this. 

Without render to screen:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 3  0  12264   6572  79004 747208    0    0     0     0 1032  1712 99  1  0  0
 2  0  12264   6444  79004 747336    0    0   128     0 1028  1654 99  1  0  0
 2  0  12264   6444  79004 747336    0    0     0     0 1041  1679 99  1  0  0
 2  0  12264   6316  79004 747464    0    0   128     0 1024  1638 98  2  0  0
 2  0  12264   6252  79040 747464    0    0     0   124 1089  1650 99  1  0  0
 1  0  12264   6124  79040 747592    0    0   128     0 1073  1679 99  1  0  0
 3  0  12264   6124  79040 747592    0    0     0     0 1025  1689 99  1  0  0
 2  0  12264   6124  79040 747592    0    0     0     0 1130  1691 99  1  0  0
 1  0  12264   5996  79040 747720    0    0   128     0 1149  1684 98  2  0  0
 2  0  12264   5996  79076 747720    0    0     0    64 1095  1720 100  0  0  0
 1  0  12264   5868  79076 747848    0    0   128     0 1205  2002 98  2  0  0


with render to screen:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 6  0  12264   8988  79528 744060    0    0    42    50   13   159 24  1 75  1
 1  0  12264   8988  79616 744060    0    0     0   164 1050  1830 99  1  0  0
 3  0  12264   8988  79616 744076    0    0    16     0 1031  1763 98  2  0  0
 1  0  12264   8988  79616 744076    0    0     0     0 1025  1771 99  1  0  0
 1  0  12264   8620  79616 744440    0    0   364     0 1059  1781 99  1  0  0
 2  0  12264   8620  79616 744440    0    0     0     0 1029  1721 99  1  0  0
 1  0  12264   8620  79652 744440    0    0     0    64 1035  1742 98  2  0  0
 3  0  12264   8492  79652 744568    0    0   128     0 1028  1703 99  1  0  0
 2  0  12264   8492  79652 744568    0    0     0     0 1028  1690 99  1  0  0
 3  0  12264   8364  79652 744696    0    0   128     0 1029  1727 97  3  0  0
 1  0  12264   8364  79652 744696    0    0     0     0 1023  1670 99  1  0  0
 1  0  12264   8236  79688 744824    0    0   128    64 1036  1705 99  1  0  0
 1  0  12264   8236  79688 744824    0    0     0     0 1024  1657 99  1  0  0
 2  0  12264   8108  79688 744952    0    0   128     0 1031  1658 98  2  0  0


Render ended:

 0  0  12264   6952  80948 745608    0    0     0   136 1044  1819 17  2 81  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  12264   6812  80948 745736    0    0   128     0 1025  1571  2  0 98  0
 2  0  12264   6812  80948 745736    0    0     0     0 1050  1532  1  1 98  0
 0  0  12264   6812  80948 745736    0    0     0     0 1172  1639  1  1 98  0
 0  0  12264   6672  80948 745864    0    0   128     0 1199  1659  3  0 97  0
 0  0  12264   6688  80972 745864    0    0     0    64 1110  1621  1  1 98  0
 0  0  12264   6688  80972 745864    0    0     0     0 1024  1582  2  0 98  0
 0  0  12264   6576  80972 745992    0    0   128     0 1024  1547  0  1 99  0
 0  0  12264   6576  80972 745992    0    0     0     0 1042  1574  2  0 98  0

-- 
Murray J. Root

