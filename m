Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265436AbUAGJNU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 04:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266156AbUAGJNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 04:13:20 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:18885 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265436AbUAGJNH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 04:13:07 -0500
Message-ID: <3FFBCDA2.9040503@namesys.com>
Date: Wed, 07 Jan 2004 12:13:06 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: venom@sns.it
CC: Steve Glines <sglines@is-cs.com>, linux-kernel@vger.kernel.org
Subject: Re: file system technical comparisons
References: <Pine.LNX.4.43.0401070036190.19759-100000@cibs9.sns.it>
In-Reply-To: <Pine.LNX.4.43.0401070036190.19759-100000@cibs9.sns.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

venom@sns.it wrote:

>On Tue, 6 Jan 2004, Hans Reiser wrote:
>
>  
>
>>balanced trees squish things together at every modification of the
>>tree.  Dancing trees squish things together when they get low on ram,
>>which is less often.  this means that we can afford to squish tighter
>>because we do it less often.
>>    
>>
>
>This is generally true except some maior cases.
>
>A SAP server, for example, is "always" low on ram, not because of oracle, but
>because how the "disp+work" processes work.
>
>Another case I am thinking is a tibco server, when processes start to fork
>because of a lot of incoming messages from everywhere, and the DB really start
>to write a lot of stuff (all small writes).
>
>I am curious to make some test in those cases.
>  
>
even if it is always low on ram, the memory pressure signal from VM is 
still less often than the tree modification because we squish in big 
batches.

>Another think I am thinking about is an MC^2 lun. If all the I/O is resolved
>inside of the EMC cache, BTrees could be better than dancing trees?
>
no, dancing trees would still fit in that cache and still be more cpu 
efficient

> In fact
>in this case what matters is the CPU power you are using, since you de facto
>talk just with EMC cache.
>
>I know those are strange scenarios, but those are the scenarios I am actually
>working with. Since those are not typical situations, I think right now they are
>ininfluent, but in the future maybe more people will have to deal with them.
>
>Anyway untill I do not make some serious experiment mine are just
>speculations.
>
>Luigi
>
>
>
>  
>
there are flaws in the reiser4 algorithms, but the dancing tree concept 
is a good one.  We are currently experimentally encountering various 
oddities needing fixing.  For instance, if your working set is just 
barely too large for ram, we have a tendency to flush too many pages out 
of ram and make you wait for us to do so.  this is fixable, and being 
discussed now amongst us.

-- 
Hans


