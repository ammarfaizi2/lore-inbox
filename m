Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268013AbUIKBn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268013AbUIKBn1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 21:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268021AbUIKBn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 21:43:27 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:22136 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268013AbUIKBnZ (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Fri, 10 Sep 2004 21:43:25 -0400
Message-ID: <41424E71.3050107@yahoo.com.au>
Date: Sat, 11 Sep 2004 11:01:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Nikita Danilov <nikita@clusterfs.com>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: 2.6.9-rc1: page_referenced_one() CPU consumption
References: <Pine.LNX.4.44.0409101315520.16623-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0409101315520.16623-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Fri, 10 Sep 2004, Hugh Dickins wrote:
> 
>>I'm quite content to go back to a trylock in page_referenced_one - and
>>in try_to_unmap_one?  But yours is the first report of an issue there,
>>so I'm inclined to wait for more reports (which should come flooding in
>>now you mention it!), and input from those with a better grasp than I
>>of how vmscan pans out in practice (Andrew, Nick, Con spring to mind).
> 
> 
> Just want to add, that there'd be little point in changing that back
> to a trylock, if vmscan ends up cycling hopelessly around a larger
> loop - though if the larger loop is more preemptible, that's a plus.
> 

Yeah - I'm not sure why a trylock would perform better. If it is just
one big address space, and memory needs to be freed, presumably the
scanner will just choose a different page, and try the lock again.

Feel like doing a few more quick tests Nikita? ;)
