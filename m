Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbTDII5D (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 04:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTDII5D (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 04:57:03 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:50949 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262927AbTDII5B (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 04:57:01 -0400
Message-ID: <3E93E36A.1050206@aitel.hist.no>
Date: Wed, 09 Apr 2003 11:10:02 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Jakob Oestergaard <jakob@unthought.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-(bk) == horrible response times for non X11 applications
References: <Pine.LNX.4.50.0304061757240.2268-100000@montezuma.mastecende.com> <20030406182435.5a243297.akpm@digeo.com> <20030409064215.GC10141@unthought.net> <3E93D345.5090209@aitel.hist.no> <20030409085231.GD10141@unthought.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Oestergaard wrote:
> On Wed, Apr 09, 2003 at 10:01:09AM +0200, Helge Hafting wrote:
> 
>>Jakob Oestergaard wrote:
>>
>>>On Sun, Apr 06, 2003 at 06:24:35PM -0700, Andrew Morton wrote:
>>
>>[...]
>>
>>>>the problem with setiathome is that it displays something every now and
>>>>then - so it gets a backboost from X, and hovers at a relatively high
>>>>priority.
>>>
>>>
>>>Why are niced processes boosted?   Does that make sense?
>>>
>>>If only non-niced processes were boosted, wouldn't that pretty much fix
>>>the problem?
>>>
>>
>>You'd have exactly the same problem for any non-niced cpu hog
>>that displays something now and then. A non-niced cpu hog is supposed
>>to be ok because the interactive processes are boosted above them.
> 
> 
> A non-niced CPU hog that has interactivity, like eh, Descent or
> Half-Life (under Wine) - well, I want those to get one heck of a lot
> more boost than my seti...  or my emacs...
> 
Sure.  I don't think your emacs will be a problem - you aren't typing
in it while playing half-life? :-)   And if you're multi-user - the other
user with his emacs has as much right to the cpu as your half-life game.

> glxgears - if I run it (I don't know why I would, but let's say I wanted
> to) - I don't want it to drop frames to favour my emacs or kword or
> whatever (in the case of glxgears maybe I would - but I wouldn't run it
> in the first place - let's just assume that glxgears is really some
> important real-time visualization application).  If emacs behaves "less
> interactively" than glxgears, then this is because glxgears is doing
> something intensive, eg. it really gets hurt if it is not heavily
> boosted.   Yes, you would be insane to run glxgears and some other
> interactive application simultaneously, and expect that both can get 90%
> of the resources - but this is the problem of limited resources and no
> amount of cleverness is going to solve that.
> 
> 
>>Gui is becoming popular, so many compute tasks get some sort of
>>display, even if it only is a progress bar.
> 
> 
> And if they update the progress bar 100 times per second, then either it
> is crucially important that this is not delayed, or the app needs
> fixing.

I'm not sure I agree on that - see below.

> You can break Linux in a million ways from user space by writing poor
> user space code.
> 
Sure.

> It wouldn't update 100 times per second unless it was important would
> it?   And if it is important, then it's a lot better to make sure it
> happens, than to ensure that the bash in the xterm next door gets it's
> timeslices exactly when it wants them.   After all, you can type in a
> laggy terminal (and if you type enough, it will get similar
> interactiveness boost and we're back to the problem of limited
> resources).
> 
> Look, I'm not trying to defend the boosting mechanism at all costs - I'm
> just trying to argue that it's not fundamentally insane.   :)

I agree that it isn't fundamentally insane, but using the 2.5.66
mechanism might force you to
concider some apps "broken" that were fine before.  This forces the
question of how hard it should be to write a user program.

100 screen updates per second doesn't mean it is important if it only
is twiddling of a baton or some progress bar.  People simply stick such
things in an outer loop - and that worked out to a update or two
per second in 1989.  Same code on todays machines results in hundreds
of updates per second.  Are we going to fix apps as our pcs becomes faster?

Cpu speed independent animations/screen updates are indeed possible, 
something
every game writer has to deal with.  But do we want to force people to do
that only so their progress bar won't go over some update treshold and
become an "interactive cpu hog" on some future fast machine?

Helge Hafting








