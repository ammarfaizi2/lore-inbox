Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbVLEXk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbVLEXk6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbVLEXk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:40:58 -0500
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:8321 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964875AbVLEXk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:40:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=4dgzBD5nfykY9HLUuPlGUFXO+Qk/0kp3UK9zDAPkoC2rveMyAGopYmC58Q9KAvBaAsK8LANIvZsFgy0lt8vONoydjbtZA+q+vwKL2PQ51evs16Y87l32e7vJhUpkBcULKQStaJScUWHY7Y/8JeKSB7AMGYhR+IPgiSTYjR5JL8A=  ;
Message-ID: <4394CFFF.3080009@yahoo.com.au>
Date: Tue, 06 Dec 2005 10:40:47 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Kenny Simpson <theonetruekenny@yahoo.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: nfs unhappiness with memory pressure
References: <20051205180139.64009.qmail@web34114.mail.mud.yahoo.com>	 <1133813590.12393.7.camel@lade.trondhjem.org>	 <1133814806.12393.10.camel@lade.trondhjem.org>	 <4394A87E.7050507@yahoo.com.au>	 <1133817536.12393.21.camel@lade.trondhjem.org> <1133817788.12393.26.camel@lade.trondhjem.org>
In-Reply-To: <1133817788.12393.26.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Mon, 2005-12-05 at 16:18 -0500, Trond Myklebust wrote:
> 
>>On Tue, 2005-12-06 at 07:52 +1100, Nick Piggin wrote:
>>
>>
>>>The VM doesn't expect to have to rely on pdflush to write out pages
>>>for it. ->writepage should be enough. Adding wakeup_pdflush here
>>>actually could do the wrong thing for non-NFS filesystems if it
>>>starts more writeback.
>>
>>nr_unstable is not going to be set for non-NFS filesystems. 'unstable'
>>is a caching state in which pages have been written out to the NFS
>>server, but the server has not yet flushed the data to disk.
> 

But if you have NFS and non-NFS filesystems, wakeup_pdflush isn't
always going to do the right thing.

> 
> ...and most important of all: 'unstable' does _not_ mean that I/O is
> active on those pages (unlike the apparent assumption in
> vm_throttle_write.
> That is why the choice is either to kick pdflush there, or to remove
> nr_unstable from the accounting in that loop.
> 

Doesn't matter if IO is actually active or not, if you've allocated
memory for these unstable pages, then page reclaim can scan itself
to death, which is what seems to have happened here. And which is
what vm_throttle_write is supposed to help.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
