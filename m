Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbVLEUw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbVLEUw0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 15:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbVLEUwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 15:52:25 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:59282 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751427AbVLEUwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 15:52:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=DPJbhre6B6UTci2YjCf/t3BwsPgiq5L0HofDcSnuJgMh3v4uYwYdPQcaBMnlgK2kh/+Rjt8K1q8lOEdAlfqpITkpRS7ypU3dNr9QC8Lrw6gwnmvxJu57YHaK52qVn1Zh5hSrBkPs3MnLLm+50rscyUNERJq3wVbfV8wo9eQ1Nc0=  ;
Message-ID: <4394A87E.7050507@yahoo.com.au>
Date: Tue, 06 Dec 2005 07:52:14 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Kenny Simpson <theonetruekenny@yahoo.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: nfs unhappiness with memory pressure
References: <20051205180139.64009.qmail@web34114.mail.mud.yahoo.com>	 <1133813590.12393.7.camel@lade.trondhjem.org> <1133814806.12393.10.camel@lade.trondhjem.org>
In-Reply-To: <1133814806.12393.10.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Mon, 2005-12-05 at 15:13 -0500, Trond Myklebust wrote:
> 

>>Can somebody VM-savvy please explain how on earth they expect something
>>like throttle_vm_writeout() to make progress? Shouldn't that thing at
>>the very least be kicking pdflush every time it loops?
> 
> 
> Can you try something like this patch, Kenny?
> 

The VM doesn't expect to have to rely on pdflush to write out pages
for it. ->writepage should be enough. Adding wakeup_pdflush here
actually could do the wrong thing for non-NFS filesystems if it
starts more writeback.

Nick

Send instant messages to your online friends http://au.messenger.yahoo.com 
