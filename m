Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbTIYIci (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 04:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbTIYIci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 04:32:38 -0400
Received: from vitelus.com ([64.81.243.207]:19862 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S261816AbTIYIce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 04:32:34 -0400
Date: Thu, 25 Sep 2003 01:31:42 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Complete I/O starvation with 3ware raid on 2.6
Message-ID: <20030925083142.GK22525@vitelus.com>
References: <20030925071252.GE22525@vitelus.com> <20030925004301.171f6645.akpm@osdl.org> <20030925075852.GI22525@vitelus.com> <20030925011052.6f8beab2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925011052.6f8beab2.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 01:10:52AM -0700, Andrew Morton wrote:
> A few things to run are `top', `ps' and `vmstat 1'.

The first two do not show any information out of the ordinary other
than the fact that the load average is 11 while only two rsync
processes are using any CPU at all.

Here is some vmstat output. It was nontrivial to caputure since
redirecting it to a file seemed to make the I/O block vmstat far too
long for it to gather useful data. Therefore, I'm not sure if the
following is accurate, despite the way I piped it to head rather than
directly to a file (hoping the pipe would block less than actual file
I/O).


procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2 10      0   2056   5196 480120    0    0  7735  7677 1135   918 11 12  2 75
 0 12      0   2040   5208 479904    0    0  5644  8196 1106   650  8 10  0 82
 0 11      0   3240   5228 478804    0    0  1148  8248 1078   279  1  1  0 98
 0 11      0   3240   5228 478824    0    0    24  8192 1057   138  0  0  0 100
 0 11      0   4344   5224 477676    0    0  2712  8108 1082   450  4  5  0 91
 0 12      0   2104   5252 479876    0    0  1544  4064 1077   352  3  3  0 94
 0 12      0   2040   5216 479972    0    0  3384  8200 1090   626  5  5  0 90
 0 12      0   1992   5220 479952    0    0  3116  8168 1092   563  4  5  0 91
 0 11      0   4500   5224 477448    0    0    92  3996 1079   125  0  0  0 100
 0 12      0   2096   5232 479892    0    0  3260  8084 1095   589  4  6  0 90
 0 11      0   2032   5232 479912    0    0  4488  8104 1101   511  6  7  0 87
 0 10      0   3808   5232 478356    0    0  8916  2208 1142  1065 12 15  0 73
 0 10      0   4960   5192 477368    0    0 17416  3716 1219  1821 23 31  0 46
 0 11      0   4512   4892 478016    0    0 15200  5132 1206  1652 23 20  0 57
 1 10      0   3808   4900 478760    0    0  6736  5364 1133  1208  9 10  0 81
 0 11      0   2096   4844 480396    0    0 28860 17220 1299  3917 43 39  0 19
 0 10      0   4060   4848 478444    0    0  8544  8008 1129   812 12 12  0 76
 0 10      0   4044   4696 478652    0    0 10928  8112 1169  1026 16 14  0 70
 0 11      0   1996   4680 480612    0    0 12752  8184 1165  1923 19 19  0 63
 1 10      0   1996   4676 480720    0    0  5532  8176 1108   550  6  8  0 86
 0 11      0   1948   4684 480608    0    0  3976  8172 1089   429  6  7  0 87
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2 10      0   1948   4680 480728    0    0 11144  4024 1150  1683 17 14  0 69
 0 11      0   2160   4700 480424    0    0 16972 12264 1210  1740 24 25  0 51
 0 13      0   2236   4732 480524    0    0 10772  4064 1161  1607 16 15  0 69
 0 11      0   4656   4696 478044    0    0   400  8196 1074   170  0  0  0 100
 0 11      0   4656   4708 478044    0    0     8  7880 1063   129  0  2  0 98
