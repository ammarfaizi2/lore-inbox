Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWAPHof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWAPHof (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 02:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWAPHof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 02:44:35 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:46704 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932234AbWAPHof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 02:44:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=3s+XHCSwwsYOU3xnwaPSBUnE4YRYtw/Xnr/z182GkXkCStBvJB5hQUm1jbEpaa1XSCJYqpRtT3VxoEi9tnhsUFmoJ7RnVa6py8r5/ljDYZdn3Cg4yC6voTDHJns+i6rSnziG0UeV9W63CN//tEj7rgCn7IEqf5hTKZMm4F1SpUw=  ;
Message-ID: <43CB4EDA.6070803@yahoo.com.au>
Date: Mon, 16 Jan 2006 18:44:26 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: Race in new page migration code?
References: <20060114155517.GA30543@wotan.suse.de> <Pine.LNX.4.62.0601140955340.11378@schroedinger.engr.sgi.com> <20060114181949.GA27382@wotan.suse.de> <Pine.LNX.4.62.0601141040400.11601@schroedinger.engr.sgi.com> <43C9DD98.5000506@yahoo.com.au> <Pine.LNX.4.62.0601152251550.17034@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0601152251550.17034@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Sun, 15 Jan 2006, Nick Piggin wrote:
> 
> 
>>OK (either way is fine), but you should still drop the __isolate_lru_page
>>nonsense and revert it like my patch does.
> 
> 
> Ok with me. Magnus: You needed the __isolate_lru_page for some other 
> purpose. Is that still the case?
> 

Either way, we can remove it from the tree for now.

But I'm almost sure such a user would be wrong too. The reason it is
required is very specific and it is because taking lru_lock and then
looking up a page on the LRU uniquely does not pin the page. If you
find the page via any other means other than simply looking on the
LRU, then get_page_testone is wrong and you should either pin it or
take a normal reference to it instead.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
