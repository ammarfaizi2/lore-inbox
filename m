Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbUEDXBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUEDXBi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 19:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUEDXBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 19:01:38 -0400
Received: from [213.171.41.46] ([213.171.41.46]:7684 "EHLO
	kaamos.homelinux.net") by vger.kernel.org with ESMTP
	id S261568AbUEDXBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 19:01:35 -0400
From: Alexey Kopytov <alexeyk@mysql.com>
Organization: MySQL AB
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: Random file I/O regressions in 2.6
Date: Wed, 5 May 2004 03:01:31 +0400
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au, peter@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
References: <200405022357.59415.alexeyk@mysql.com> <1083683034.13688.7.camel@localhost.localdomain> <1083699554.13688.64.camel@localhost.localdomain>
In-Reply-To: <1083699554.13688.64.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Message-Id: <200405050301.32355.alexeyk@mysql.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Pai wrote:
>Without the patch:
>------------------
>Time spent for test:  20.6661s
>
>no of times window reset because of hits: 0
>no of times window reset because of misses: 7
>no of times window was shrunk because of hits: 6716
>no of times the page request was non-contiguous: 5880
>no of times the page request was contiguous : 19639
>
>With the patch:
>--------------
>Time spent for test:  19.5370s
>
>no of times window got reset because of hits: 0
>no of times window got reset because of misses: 0
>no of times window was shrunk because of hits: 5844
>no of times the page request was non-contiguous: 5830
>no of times the page request was contiguous : 20232
>
>Would be nice if Alexey tries the patch on his machine and sees any
>major difference.

Here's what I have (same hardware and test setups):

Without the patch (but with Ram's patch applied):
------------------
Time spent for test: 125.4429s

no of times window reset because of hits: 0
no of times window reset because of misses: 127
no of times window was shrunk because of hits: 1153
no of times the page request was non-contiguous: 3968
no of times the page request was contiguous : 10686

With the patch:
---------------
Time spent for test:  86.5459s

no of times window reset because of hits: 0
no of times window reset because of misses: 0
no of times window was shrunk because of hits: 1066
no of times the page request was non-contiguous: 5860
no of times the page request was contiguous : 18099

I wonder if there are some plans to further improve 2.6 behavior on this 
workload to match that of 2.4? Is the remaing regression a result of the 
different readahead handling, or it might be caused by IDE driver or I/O 
scheduler tuning?

-- 
Alexey Kopytov, Software Developer
MySQL AB, www.mysql.com

Are you MySQL certified?  www.mysql.com/certification
