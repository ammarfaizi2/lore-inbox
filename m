Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932760AbWEXRzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbWEXRzs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 13:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932761AbWEXRzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 13:55:48 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:6842 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932760AbWEXRzr (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 24 May 2006 13:55:47 -0400
Message-ID: <44749E24.40203@namesys.com>
Date: Wed, 24 May 2006 10:55:48 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Vier <tmv@comcast.net>
CC: Linux-Kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Reiserfs mail-list <Reiserfs-List@namesys.com>
Subject: Re: [PATCH] updated reiser4 - reduced cpu usage for writes by writing
 more than 4k at a time (has implications for generic write code and eventually
 for the IO layer)
References: <44736D3E.8090808@namesys.com> <20060524175312.GA3579@zero>
In-Reply-To: <20060524175312.GA3579@zero>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Vier wrote:

>On Tue, May 23, 2006 at 01:14:54PM -0700, Hans Reiser wrote:
>  
>
>>underlying FS can be improved.  Performance results show that the new
>>code consumes  40% less CPU when doing "dd bs=1MB ....." (your hardware,
>>and whether the data is in cache, may vary this result).  Note that this
>>has only a small effect on elapsed time for most hardware.
>>    
>>
>
>Write requests in linux are restricted to one page?
>
>  
>
It may go to the kernel as a 64MB write, but VFS sends it to the FS as
64MB/4k separate 4k writes.
