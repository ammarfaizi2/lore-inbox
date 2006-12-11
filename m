Return-Path: <linux-kernel-owner+w=401wt.eu-S937065AbWLKQn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937065AbWLKQn6 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937189AbWLKQn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:43:58 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:29918 "HELO
	smtp106.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S937072AbWLKQn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:43:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=hpwB5ixtJ/lN95gFuLsREvsSgRO5qb1poa54D+7sqIibwd//EKrt8ULQHwsFZiqEHMMPbpRbJup4MC2Pkd8JqfUu+FbyUCBNgZRBvWVdmSdK7kv9rhmwG9609VRLCYKZeIHNltV4+u/62IoZuwc1NAccfAUiTcGLeypCUOmRvKc=  ;
X-YMail-OSG: IbFN6ycVM1nVZhbLfUBCldxBs66Leilw.6vjoT81As625KGlkaeq22vnGxg2z.sKqF9I0q7vGxxJBFmJMcFqUQJcUQF_VrwDdaSixRdPmG0EjRsmtyPUfEYUKAbEWyslVmalmQr9Hgc3JTA-
Message-ID: <457D89DA.5010705@yahoo.com.au>
Date: Tue, 12 Dec 2006 03:39:54 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Whitehouse <steve@chygwyn.com>
CC: Mark Fasheh <mark.fasheh@oracle.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@google.com>
Subject: Re: Status of buffered write path (deadlock fixes)
References: <45751712.80301@yahoo.com.au>	 <20061207195518.GG4497@ca-server1.us.oracle.com>	 <4578DBCA.30604@yahoo.com.au>	 <20061208234852.GI4497@ca-server1.us.oracle.com>	 <457D20AE.6040107@yahoo.com.au>  <457D7EBA.7070005@yahoo.com.au> <1165853552.3752.1015.camel@quoit.chygwyn.com>
In-Reply-To: <1165853552.3752.1015.camel@quoit.chygwyn.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Whitehouse wrote:

>>Hmm, doesn't look like we can do this either because at least GFS2
>>uses BH_New for its own special things.
>>
> 
> What makes you say that? As far as I know we are not doing anything we
> shouldn't with this flag, and if we are, then I'm quite happy to
> consider fixing it up so that we don't,

Bad wording. Many other filesystems seem to only make use of buffer_new
between prepare and commit_write.

gfs2 seems to at least test it in a lot of places, so it is hard to know
whether we can change the current semantics or not. I didn't mean that
gfs2 is doing anything wrong.

So can we clear it in commit_write?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
