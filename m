Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSIDVVj>; Wed, 4 Sep 2002 17:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315458AbSIDVVj>; Wed, 4 Sep 2002 17:21:39 -0400
Received: from pD951DABD.dip.t-dialin.net ([217.81.218.189]:32229 "EHLO
	sol.fo.et.local") by vger.kernel.org with ESMTP id <S315454AbSIDVVi>;
	Wed, 4 Sep 2002 17:21:38 -0400
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] mount flag "direct" (fwd)
References: <200209032107.g83L71h10758@oboe.it.uc3m.es>
	<m38z2i9os2.fsf@venus.fo.et.local> <3D75F8B0.8C7E974E@aitel.hist.no>
From: Joachim Breuer <jmbreuer@gmx.net>
Date: Wed, 04 Sep 2002 23:26:08 +0200
In-Reply-To: <3D75F8B0.8C7E974E@aitel.hist.no> (Helge Hafting's message of
 "Wed, 04 Sep 2002 14:12:32 +0200")
Message-ID: <m3heh5la4v.fsf@venus.fo.et.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Common Lisp,
 i386-redhat-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> writes:

> Joachim Breuer wrote:
>> > Well, one has to read it from scratch. I'll set about seeing how to do.
>> > CLues welcome.
>> 
>> Just an idea, I don't know how well this works what with the 'IDE
>> can't do write barriers right' and related effects:
>> 
>> - Allow all nodes to cache as many blocks as they wish
>> - The atomic operation "update this block" includes "invalidate this
>>   block, if cached" broadcast to all nodes
>> 
> You can't just invalidate like that, you'll need synchronization.
> Something like "I want write access to this block - stop using it."
> And then you _wait_, until everybody else has released it.  This
> could take some time if someone was busy using it.

More or less what I meant - I assumed the requirement of mutual
exclusion was already agreed upon. I might have phrased it more
clearly as in "the locking protocol provides the "other" nodes with
sensible invalidation data". Something which a "budgeting" type
locking protocol would not normally do (allow each node a range of its
own for exclusive writes; everyone can read everywhere (with a bit
more locking to make the writes look atomic if they aren't already
perhaps)).

>> Performance would certainly become an issue; depending on the
>> architecture bus sniffing as in certain MP cache consistency protocols
>> might be feasible (I, node 3, see a transfer from node 1 going to
>> block #42, which is in my cache; so I update my cache using the data
>> part of the block transfer as it comes by on the bus).
>
> Possible only when there is a shared bus.  Of course today's
> IDE/SCSI don't do this.

Well, SCSI can be *made* to do it (actually, this is what I had in
mind when I wrote it up) - but I don't know whether any mainstream
controllers would be able to "sniff" sensibly.


Anyway, so long,
        Joe

-- 
"I use emacs, which might be thought of as a thermonuclear
 word processor."
-- Neal Stephenson, "In the beginning... was the command line"
