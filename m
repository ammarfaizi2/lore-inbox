Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbUJXOCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbUJXOCo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 10:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbUJXOCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 10:02:44 -0400
Received: from mail.tmr.com ([216.238.38.203]:14854 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261481AbUJXOCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 10:02:38 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Gigantic memory leak in linux-2.6.[789]!
Date: Sun, 24 Oct 2004 10:14:36 -0400
Organization: TMR Associates, Inc
Message-ID: <clgc6m$u72$1@gatekeeper.tmr.com>
References: <200410221613.35913.ks@cs.aau.dk><200410221613.35913.ks@cs.aau.dk> <Pine.LNX.4.60.0410221743590.20604@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1098626070 30946 192.168.12.10 (24 Oct 2004 13:54:30 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.60.0410221743590.20604@dlang.diginsite.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:

> This puts the cost of zeroing out and freeing memory on new programs 
> that are allocating memory, which tends to scatter the work over time 
> rather then having a large burst of work kick in when a program exits 
> (it seems odd to think that if a large computer exits the machine would 
> be pegged for a little while while it frees up and zeros the memory, not 
> exactly what you would expect when you killed a program :-)

Any this partially explains why response is bad every morning when 
starting daily operation. Instead of using the totally unproductive time 
in the idle loop to zero and free those pages when it would not hurt 
response, the kernel saves that work for the next time the memory is 
needed lest it do work which might not be needed before the system is 
shutdown.

With all the work Nick, Ingo,Con and others are putting into latency and 
responsiveness, I don't understand why anyone thinks this is desirable 
behavior. The idle loop is the perfect place to perform things like 
this, to convert non-productive cycles into performing tasks which will 
directly improve response and performance when the task MUST be done. 
Things like zeroing these pages, perhaps defragmenting memory, anything 
which can be done in small parts.

It would seem that doing things like this in small inefficient steps in 
idle moments is still better than doing them efficiently while a process 
is waiting for the resources being freed.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
