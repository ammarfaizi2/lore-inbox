Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWACFME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWACFME (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 00:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWACFMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 00:12:00 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:26008 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751160AbWACFL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 00:11:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=Dyan7z71L2vIOqu/U7SKysLkwCu/wE+iQBfw5hglC2/yONp7joCF0LmHHVA79zBHZ1ku11AQmxq7fkuDHOkmMosg/f9tm5rGSTDkNo3M7q7esWxou43hfng7nfzEozgE+wMSXiq2PAVt235hkQaVIz4Gf/5ocFN10jYIKhnRtis=  ;
Subject: Re: [RFC] Event counters [1/3]: Basic counter functionality
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Christoph Lameter <clameter@sgi.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>
In-Reply-To: <20060102214016.GA13905@dmt.cnet>
References: <20051220235733.30925.55642.sendpatchset@schroedinger.engr.sgi.com>
	 <20051231064615.GB11069@dmt.cnet> <43B63931.6000307@yahoo.com.au>
	 <20051231202602.GC3903@dmt.cnet>  <20060102214016.GA13905@dmt.cnet>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 16:11:46 +1100
Message-Id: <1136265106.5261.34.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-02 at 19:40 -0200, Marcelo Tosatti wrote:

> Nick, 
> 
> The following patch:
> 
> - Moves the lightweight "inc/dec" versions of mod_page_state variants
> to three underscores, making those the default for locations where enough
> locks are held.
> 

I guess I was hoping to try to keep it simple, and just have two
variants, the __ version would require the caller to do the locking.
In cases like eg. allocstall, they should happen infrequently enough
that the extra complexity is probably not worth worrying about.

I don't think I commented about the preempt race though (and requirement
to have preempt off from process context), which obviously can be a
problem as you say (though I think things are currently safe?).

> - Make the two-underscore version disable and enable preemption, which 
> is required to avoid preempt-related races which can result in missed
> updates.
> 
> - Extends the lightweight version usage in page reclaim, 
> pte allocation, and a few other codepaths.
> 

I guess nr_dirty looks OK in the places it can be put under tree_lock.

nr_page_table_pages is OK because ptl should be held to prevent preempt.

pgrotated and pgactivate should be good because of lru_lock.

Thanks for going through these!

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
