Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWCIHnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWCIHnQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 02:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWCIHnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 02:43:16 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:47775 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750767AbWCIHnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 02:43:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=xkN/K9WGLb0LSGFbN8vAGSu2Ki/vrGb5GRhLvJSbFDfCe0b8wK+PUA16SjNnGY+voaSJTz3epAfDFTQJ6MLOyQw+MIigzcvZgqGdDFK+TsIUCntU6+/9a/y+sAxWazo3pNuuEVfZpMDlxhBlxprrz+308IrvOT7TecsE7GI0Upc=  ;
Message-ID: <440FDC8E.9060907@yahoo.com.au>
Date: Thu, 09 Mar 2006 18:43:10 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@google.com>
CC: Mark Fasheh <mark.fasheh@oracle.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com
Subject: Re: [Ocfs2-devel] Ocfs2 performance bugs of doom
References: <4408C2E8.4010600@google.com>	<20060303233617.51718c8e.akpm@osdl.org>	<440B9035.1070404@google.com>	<20060306025800.GA27280@ca-server1.us.oracle.com>	<440BC1C6.1000606@google.com>	<20060306195135.GB27280@ca-server1.us.oracle.com>	<p733bhvgc7f.fsf@verdi.suse.de> <20060307045835.GF27280@ca-server1.us.oracle.com> <440FCA81.7090608@google.com>
In-Reply-To: <440FCA81.7090608@google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

> A poor distribution as you already noticed[1].  Even if it was a great
> distribution, we would still average a little over two nodes per bucket
> twice as many as we should allow unless you believe that people running
> cluster filesystems have too much time on their hands and need to waste
> some of it waiting for the computer to chew its way through millions
> of cold cache lines.
> 

Just interested: do the locks have any sort of locality of lookup?
If so, then have you tried moving hot (ie. the one you've just found,
or newly inserted) hash entries to the head of the hash list?

In applications with really good locality you can sometimes get away
with small hash tables (10s even 100s of collisions on average) without
taking too big a hit this way, because your entries basically get sorted
LRU for you.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
