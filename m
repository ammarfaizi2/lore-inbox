Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbVLFFnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbVLFFnE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 00:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbVLFFnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 00:43:03 -0500
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:1902 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964825AbVLFFnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 00:43:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=xlX7pO8CpvzM66om+qzpe/fXkLt+lTbp+Ah9OHr8/Q3l51gxXBeh95XPbTSl7ForbVynkD1f3+ZYRbzVO5zvBo/ys6KKTLbvTIT+3omr7F1DvYrmkfrOYJ4kjBDnpvzX9EvWBbsZSHUFvFIFR0NT6hALO198J7e8q6vrrxWbT5E=  ;
Message-ID: <439524E2.7050500@yahoo.com.au>
Date: Tue, 06 Dec 2005 16:42:58 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Andrew Morton <akpm@osdl.org>, theonetruekenny@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: nfs unhappiness with memory pressure
References: <20051205210442.17357.qmail@web34106.mail.mud.yahoo.com>	 <1133822367.8003.5.camel@lade.trondhjem.org>	 <20051206143641.3feadaea.akpm@osdl.org> <1133844026.8007.36.camel@lade.trondhjem.org>
In-Reply-To: <1133844026.8007.36.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Tue, 2005-12-06 at 14:36 +1100, Andrew Morton wrote:
> 
>>Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>>
>>>Argh... Not sure entirely how to deal with that... We definitely don't
>>> want the thing futzing around inside throttle_vm_writeout(), 'cos
>>> writeout isn't going to happen while the socket blocks.
>>>
>>
>>As far as the core VM is concerned, these pages are really "dirty", only it
>>happens to be a different flavour of dirtiness.  So perhaps we should
>>continue to mark these pages as dirty and let NFS internally take care
>>of which end of the wire they're dirty at.
>>
>>Presumably calling writepage() a second time won't be very useful.  Or will
>>it?  Perhaps when NFS sees writepage against a PageDirty && PageUnstable
>>page it can recognise that as a hint to kick off a server-side write.
> 
> 
> Calling writepages() would actually be better. That will do the right
> thing, and trigger a commit if there are unstable writes.
> 

writepage should as well, then it would have a better chance
of just doing the right thing.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
