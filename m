Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264277AbUEIH3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbUEIH3O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 03:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUEIH3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 03:29:14 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:65422 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264277AbUEIH3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 03:29:12 -0400
Message-ID: <409DDDAE.3090700@colorfullife.com>
Date: Sun, 09 May 2004 09:28:46 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, wli@holomorphy.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: dentry bloat.
References: <20040506200027.GC26679@redhat.com> <20040506150944.126bb409.akpm@osdl.org> <409B1511.6010500@colorfullife.com> <20040508012357.3559fb6e.akpm@osdl.org> <20040508022304.17779635.akpm@osdl.org> <20040508031159.782d6a46.akpm@osdl.org> <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org> <20040508120148.1be96d66.akpm@osdl.org> <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org> <Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org> <20040508204239.GB6383@in.ibm.com>
In-Reply-To: <20040508204239.GB6383@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:

>On Sat, May 08, 2004 at 12:27:50PM -0700, Linus Torvalds wrote:
>  
>
>>And yes, removing d_movecount would be ok by then, as long as we re-test
>>the parent inside d_lock (we don't need to re-test "hash", since if we
>>tested the full name inside the lock, the hash had better match too ;)
>>    
>>
What's the prupose of d_move_count?
AFAICS it protects against a double rename: first to different bucket, 
then back to original bucket. This changes the position of the dentry in 
the hash chain and a concurrent lookup would skip entries.
d_lock wouldn't prevent that.

But I think d_bucket could be removed: for __d_lookup the test appears 
to be redundant with the d_move_count test. The remaining users are not 
performance critical, they could recalculate the bucket from d_parent 
and d_name.hash.

--
    Manfred

