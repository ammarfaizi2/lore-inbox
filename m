Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268390AbTGIPmJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 11:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268396AbTGIPmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 11:42:09 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:469 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268390AbTGIPll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 11:41:41 -0400
Message-ID: <3F0C3F32.40301@kegel.com>
Date: Wed, 09 Jul 2003 09:13:38 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
CC: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org
Subject: Re: Redundant memset in AIO read_events
References: <DD755978BA8283409FB0087C39132BD101B00F79@fmsmsx404.fm.intel.com>
In-Reply-To: <DD755978BA8283409FB0087C39132BD101B00F79@fmsmsx404.fm.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luck, Tony wrote:
> That is true, but here's the definition of the io_event strcuture:
> 
> struct io_event {
>         __u64           data;
>         __u64           obj;
>         __s64           res;
>         __s64           res2;
> };
> 
> In the words of the comment, C may be "fun", but I've
> having trouble envisioning an architecture where a structure
> that consists of four equal sized objects has some padding!

<newbie>
There might be some architecture that requires 16 byte alignment...
how about surrounding the memcpy with if (sizeof(struct io_event) != 4 * sizeof(__u64)) ?
</newbie>

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

