Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWCVMBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWCVMBn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 07:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWCVMBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 07:01:42 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:23739 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750830AbWCVMBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 07:01:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=gA+S5NeayQxSGyNC1pA6zFn2w5H0WW681Cku3kTz3dEFRBCuteP8hQRhYkMVDAG4XC5HZ578HpqxVw8tiAOYXsSA6H6zmepdpvyGY6rXqiXo7FQvTPfcmLns7tsDglArvq0PT/imSltciqZ3Rpc7A0gmn82+MxobbngtoXg1F64=  ;
Message-ID: <44213333.6030404@yahoo.com.au>
Date: Wed, 22 Mar 2006 22:21:23 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
CC: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 30/35] Add generic_page_range() function
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063805.741915000@sorel.sous-sol.org>
In-Reply-To: <20060322063805.741915000@sorel.sous-sol.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> Add a new mm function generic_page_range() which applies a given
> function to every pte in a given virtual address range in a given mm
> structure. This is a generic alternative to cut-and-pasting the Linux
> idiomatic pagetable walking code in every place that a sequence of
> PTEs must be accessed.
> 
> Although this interface is intended to be useful in a wide range of
> situations, it is currently used specifically by several Xen
> subsystems, for example: to ensure that pagetables have been allocated
> for a virtual address range, and to construct batched special
> pagetable update requests to map I/O memory (in ioremap()).
> 

I raised the idea when we were tossing around ideas for the page
table walking crapectomy. Of course it was rejected due to use of
the indirect function, however I gues it makes sense for code
outside mm/

Couple of issues with the current code though:

firstly, the name.

secondly, I think you confuse our (confusing) terminology: the page
that holds pte_ts is not the pte_page, the pte_page is the page that
a pte points to

lastly, you don't allow any control over the type of pages that are
walked: this could well be unusably slow for some cases. At least
you should proably design the interface so we can iterate over
present, not present, all, etc so it becomes widely usable. Normally
I'd say to wait until users come up but in this case the function
isn't a speed demon anyway, and you also don't want to give people
any excuses not to use it.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
