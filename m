Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbVHLHxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVHLHxm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 03:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbVHLHxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 03:53:42 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:20844 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932386AbVHLHxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 03:53:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=bOffkb/WF437SEIbzoZxtRjB1SVxdie35Z47HOcPARmN1NcI15phMGyRuJL1zdbdgM/WTUOhEaSIYGayBO4DMabbI50rd/1Y4VukzoG+HYC+uhRds6K6WI5ZuJGnMNXlpMGlVNopZWdZBIPQ1lvMV+eDVbYw0QuFM9C1qklCDUE=  ;
Message-ID: <42FC557E.5090903@yahoo.com.au>
Date: Fri, 12 Aug 2005 17:53:34 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: Paul McKenney <paul.mckenney@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 5/7] radix-tree: lockless readside
References: <42FB4201.7080304@yahoo.com.au> <42FB42BD.6020808@yahoo.com.au>	 <42FB42EF.1040401@yahoo.com.au> <42FB4311.2070807@yahoo.com.au>	 <42FB43A8.8060902@yahoo.com.au> <42FB43CB.5080403@yahoo.com.au>	 <20050812013703.GP1300@us.ibm.com> <1123821515.5098.39.camel@npiggin-nld.site>
In-Reply-To: <1123821515.5098.39.camel@npiggin-nld.site>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> With the above, we can meet the same requirements of the current
> find_get_page. Which basically are:
> 
> x) If the page was ever[1] in pagecache, it may be returned
> y) If the pagecache was ever[2] empty, NULL may be returned
> 

Oh, I missed a couple of "obvious" ones.

More correctly:

x1) If a page was ever in pagecache, it may be returned.
x1) If not, then NULL will be returned.

y1) If the pagecache was ever empty, NULL may be returned.
y2) If not, then the page will be returned.


-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
