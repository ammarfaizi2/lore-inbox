Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319095AbSIDHqJ>; Wed, 4 Sep 2002 03:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319090AbSIDHqJ>; Wed, 4 Sep 2002 03:46:09 -0400
Received: from pD9E539D4.dip.t-dialin.net ([217.229.57.212]:35813 "EHLO
	sol.fo.et.local") by vger.kernel.org with ESMTP id <S319095AbSIDHqI>;
	Wed, 4 Sep 2002 03:46:08 -0400
To: ptb@it.uc3m.es
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mount flag "direct" (fwd)
References: <200209032107.g83L71h10758@oboe.it.uc3m.es>
From: Joachim Breuer <jmbreuer@gmx.net>
Date: Wed, 04 Sep 2002 09:50:37 +0200
In-Reply-To: <200209032107.g83L71h10758@oboe.it.uc3m.es> ("Peter T.
 Breuer"'s message of "Tue, 3 Sep 2002 23:07:01 +0200 (MET DST)")
Message-ID: <m38z2i9os2.fsf@venus.fo.et.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Common Lisp,
 i386-redhat-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer" <ptb@it.uc3m.es> writes:

> "A month of sundays ago Lars Marowsky-Bree wrote:"
>> On 2002-09-03T18:29:02,
>>    "Peter T. Breuer" <ptb@it.uc3m.es> said:
>>
>> > The directory entry would certainly have to be reread after a write
>> > operation on disk that touched it - or more simply, the directory entry
>> > would have to be reread every time it were needed, i.e. be uncached.
>> 
>> *ouch* Sure. Right. You just have to read it from scratch every time. How
>> would you make readdir work?
>
> Well, one has to read it from scratch. I'll set about seeing how to do.
> CLues welcome.

Just an idea, I don't know how well this works what with the 'IDE
can't do write barriers right' and related effects:

- Allow all nodes to cache as many blocks as they wish
- The atomic operation "update this block" includes "invalidate this
  block, if cached" broadcast to all nodes

Performance would certainly become an issue; depending on the
architecture bus sniffing as in certain MP cache consistency protocols
might be feasible (I, node 3, see a transfer from node 1 going to
block #42, which is in my cache; so I update my cache using the data
part of the block transfer as it comes by on the bus).


So long,
   Joe

-- 
"I use emacs, which might be thought of as a thermonuclear
 word processor."
-- Neal Stephenson, "In the beginning... was the command line"
