Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbUBWAaC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 19:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbUBWAaC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 19:30:02 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:933 "HELO mail.iinet.net.au")
	by vger.kernel.org with SMTP id S261293AbUBWA36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 19:29:58 -0500
Message-ID: <40394982.9090300@cyberone.com.au>
Date: Mon, 23 Feb 2004 11:29:54 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, cw@f00f.org, mfedyk@matchmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
References: <4037FCDA.4060501@matchmail.com> <20040222023638.GA13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org> <20040222031113.GB13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org> <20040222033111.GA14197@dingdong.cryptoapps.com> <4038299E.9030907@cyberone.com.au> <40382BAA.1000802@cyberone.com.au> <4038307B.2090405@cyberone.com.au> <20040221220927.198749d4.akpm@osdl.org> <Pine.LNX.4.58.0402220903360.3301@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402220903360.3301@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus Torvalds wrote:

>
>On Sat, 21 Feb 2004, Andrew Morton wrote:
>
>>yeah.  We should have made that change when making shrink_slab() ignore
>>highmem scanning.
>>
>>Something like this (the function needs a rename)
>>
>
>Why not just pass in the list of zones? That way the _caller_ determines 
>what zones he is interested in.
>
>So just add a "struct zonelist *zonelist" as the argument, the same way 
>"__alloc_pages()" has..
>
>

The caller might as well just pass in the total size of all
LRUs that it has scanned. It has to traverse the zones anyway,
and this enables it to take the size *before* shrinking, which
gives you a better number.

