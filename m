Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbVKCSEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbVKCSEZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 13:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbVKCSEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 13:04:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12268 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030400AbVKCSEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 13:04:24 -0500
Date: Thu, 3 Nov 2005 10:03:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: Mel Gorman <mel@csn.ul.ie>, Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <311050000.1131040276@[10.10.2.4]>
Message-ID: <Pine.LNX.4.64.0511030955110.27915@g5.osdl.org>
References: <4366C559.5090504@yahoo.com.au>
 <Pine.LNX.4.58.0511010137020.29390@skynet><4366D469.2010202@yahoo.com.au>
 <Pine.LNX.4.58.0511011014060.14884@skynet><20051101135651.GA8502@elte.hu>
 <1130854224.14475.60.camel@localhost><20051101142959.GA9272@elte.hu>
 <1130856555.14475.77.camel@localhost><20051101150142.GA10636@elte.hu>
 <1130858580.14475.98.camel@localhost><20051102084946.GA3930@elte.hu>
 <436880B8.1050207@yahoo.com.au><1130923969.15627.11.camel@localhost>
 <43688B74.20002@yahoo.com.au><255360000.1130943722@[10.10.2.4]>
 <4369824E.2020407@yahoo.com.au>
 <306020000.1131032193@[10.10.2.4]><1131032422.2839.8.camel@laptopd505.fenrus.org><Pine.LNX.4.64.0511030747450.27915@g5.osdl.org><Pine.LNX.4.58.0511031613560.3571@skynet>
 <Pine.LNX.4.64.0511030842050.27915@g5.osdl.org><309420000.1131036740@[10.10.2.4]>
 <Pine.LNX.4.64.0511030918110.27915@g5.osdl.org> <311050000.1131040276@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Nov 2005, Martin J. Bligh wrote:
> > And I suspect that by default, there should be zero of them. Ie you'd have 
> > to set them up the same way you now set up a hugetlb area.
> 
> So ... if there are 0 by default, and I run for a while and dirty up
> memory, how do I free any pages up to put into them? Not sure how that
> works.

You don't.

Just face it - people who want memory hotplug had better know that 
beforehand (and let's be honest - in practice it's only going to work in 
virtualized environments or in environments where you can insert the new 
bank of memory and copy it over and remove the old one with hw support).

Same as hugetlb.

Nobody sane _cares_. Nobody sane is asking for these things. Only people 
with special needs are asking for it, and they know their needs.

You have to realize that the first rule of engineering is to work out the 
balances. The undeniable fact is, that 99.99% of all users will never care 
one whit, and memory management is complex and fragile. End result: the 
0.01% of users will have to do some manual configuration to keep things 
simpler for the cases that really matter.

Because the case that really matters is the sane case. The one where we
 - don't change memory (normal)
 - only add memory (easy)
 - only switch out memory with hardware support (ie the _hardware_ 
   supports parallel memory, and you can switch out a DIMM without 
   software ever really even noticing)
 - have system maintainers that do strange things, but _know_ that.

We simply DO NOT CARE about some theoretical "general case", because the 
general case is (a) insane and (b) impossible to cater to without 
excessive complexity.

Guys, a kernel developer needs to know when to say NO.

And we say NO, HELL NO!! to generic software-only memory hotplug.

If you are running a DB that needs to benchmark well, you damn well KNOW 
IT IN ADVANCE, AND YOU TUNE FOR IT.

Nobody takes a random machine and says "ok, we'll now put our most 
performance-critical database on this machine, and oh, btw, you can't 
reboot it and tune for it beforehand". And if you have such a person, you 
need to learn to IGNORE THE CRAZY PEOPLE.

When you hear voices in your head that tell you to shoot the pope, do you 
do what they say? Same thing goes for customers and managers. They are the 
crazy voices in your head, and you need to set them right, not just 
blindly do what they ask for.

		Linus
