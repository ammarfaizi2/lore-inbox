Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVIUAdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVIUAdj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 20:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVIUAdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 20:33:38 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:3661 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP
	id S1750822AbVIUAdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 20:33:38 -0400
Message-ID: <4330A8F2.7010903@emc.com>
Date: Tue, 20 Sep 2005 20:27:30 -0400
From: Ric Wheeler <ric@emc.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Pavel Machek <pavel@suse.cz>, Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl> <432E5024.20709@namesys.com> <20050920075133.GB4074@elf.ucw.cz> <20050921000425.GF6179@thunk.org>
In-Reply-To: <20050921000425.GF6179@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.9.19.6
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='EMC_FROM_00+ 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:

> 
> Another interesting refinement would be to analyze the resulting
> filesystem after it has been repaired to determine how much data could
> be salvaged by the fsck program.   

We use reiserfs3 to store data and have had very good luck in getting 
data off of real world, hard disk failures.  In our case, we have a 
digital signature which is used to compare validate the content of the 
files after recovery so we have an extra comfort level with the results 
of a repaired file system...

Working on getting fsck to run reliably and quickly on large file 
systems (any type of file system) is certainly a big item on our wish 
list.  With relatively small file system (320GB) we can spend hours 
trying to recover.

> 
> There is a very interesting paper that I coincidentally just came
> across today that talks about making filesystems robust against
> various different forms of failures of modern disk systems.  It is
> going to be presented at the upcoming 2005 SOSP conference.
> 
> 	http://www.cs.wisc.edu/adsl/Publications/iron-sosp05.pdf
> 
> It's definitely worth a read.  A few comments about it; first of all,
> I know nothing about this modified "iron ext3" (ixt3) discussed in the
> paper aside from what's the paper itself.  It would be interesting to
> see what they have done with it.  Secondly, I _think_ sct has already
> fixed the problems discussed in the paper with respect to inadequate
> write squelching after an I/O failure writing to the ext3 journal, but
> we need to chat with the paper's authors to confirm that, and if there
> still is a problem, obviously we need to fix it.  Third of all, I'll
> note that the paper does takes an approving note of the fact that
> Reiserfs (v3) always panic's when it detects a write fault, so for
> those folks in the Reiser team who might have a persecution complex,
> relax, the whole world isn't out to get you.  :-)
> 
> 						- Ted

We have been sponsors of this work at Wisconsin - a good group with 
interesting results.

As an earlier thread on lkml showed this summer, we still have a long 
way to go to getting consistent error semantics in face of media 
failures between the various file systems.  I am not sure that we even 
have consensus on what that default behavior should be between 
developers, so image how difficult life is for application writers who 
want to try to ride through or write automated "HA" recovery scripts for 
systems with large numbers of occasionally flaky IO devices ;-)

Ric




