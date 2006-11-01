Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752258AbWKASZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbWKASZJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 13:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752260AbWKASZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 13:25:09 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:16428 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1752256AbWKASZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 13:25:04 -0500
Message-ID: <4548E581.1010509@oracle.com>
Date: Wed, 01 Nov 2006 10:20:49 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Derek Fults <dfults@sgi.com>
CC: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Add get_range, allows a hyhpenated range to get_options
References: <1162398157.9524.490.camel@lnx-dfults.americas.sgi.com>	 <20061101085722.18430d23.randy.dunlap@oracle.com>	 <1162402145.9524.501.camel@lnx-dfults.americas.sgi.com>	 <4548DB0C.3050601@oracle.com> <1162404964.9524.524.camel@lnx-dfults.americas.sgi.com>
In-Reply-To: <1162404964.9524.524.camel@lnx-dfults.americas.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Derek Fults wrote:
>> How does get_range() handle errors, like input of
>> 	64-60
>> or	64-N
>> or	64-
>> ?
>>
> get_range will return a negative value which caused it to break out of
> the while loop on the next iteration.  I've added a check of the
> get_range return value to break immediately. See snippet.  
> If get_options is called with a bad range, 
> 64-N,65
> returns and empty array.
> 63,64-N
> returns an array with just 63.  

OK, thanks.

> 		if (res == 3) {
> 			int range_nums;
> 			range_nums = get_range((char **)&str, ints + i);
> +			if ( range_nums < 0)

no space after '('

> +					break;
> 			/* Decrement the result by one to leave out the
> 			   last number in the range.  The next iteration
> 			   will handle the upper number in the range */
> 			i += (range_nums - 1);
> 		}
> 
> Derek


-- 
~Randy
