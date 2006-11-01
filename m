Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752249AbWKASPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbWKASPV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 13:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752251AbWKASPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 13:15:21 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:26006 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1752250AbWKASPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 13:15:19 -0500
Subject: Re: [PATCH] Add get_range, allows a hyhpenated range to get_options
From: Derek Fults <dfults@sgi.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
In-Reply-To: <4548DB0C.3050601@oracle.com>
References: <1162398157.9524.490.camel@lnx-dfults.americas.sgi.com>
	 <20061101085722.18430d23.randy.dunlap@oracle.com>
	 <1162402145.9524.501.camel@lnx-dfults.americas.sgi.com>
	 <4548DB0C.3050601@oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Nov 2006 12:16:04 -0600
Message-Id: <1162404964.9524.524.camel@lnx-dfults.americas.sgi.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> How does get_range() handle errors, like input of
> 	64-60
> or	64-N
> or	64-
> ?
> 
get_range will return a negative value which caused it to break out of
the while loop on the next iteration.  I've added a check of the
get_range return value to break immediately. See snippet.  
If get_options is called with a bad range, 
64-N,65
returns and empty array.
63,64-N
returns an array with just 63.  

		if (res == 3) {
			int range_nums;
			range_nums = get_range((char **)&str, ints + i);
+			if ( range_nums < 0)
+					break;
			/* Decrement the result by one to leave out the
			   last number in the range.  The next iteration
			   will handle the upper number in the range */
			i += (range_nums - 1);
		}

Derek
