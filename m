Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbTDGTQi (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 15:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTDGTQi (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 15:16:38 -0400
Received: from findaloan-online.cc ([216.209.85.42]:30478 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S263596AbTDGTQh (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 15:16:37 -0400
Date: Mon, 7 Apr 2003 15:35:34 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Schlichter <schlicht@rumms.uni-mannheim.de>,
       linux-kernel@vger.kernel.org
Subject: Re: An idea for prefetching swapped memory...
Message-ID: <20030407193534.GD7311@mark.mielke.cc>
References: <200304071026.47557.schlicht@uni-mannheim.de> <200304072021.17080.kernel@kolivas.org> <1049712476.3e91575c2e6ae@rumms.uni-mannheim.de> <3E917BFA.4020303@aitel.hist.no> <3E9188ED.1090109@nortelnetworks.com> <20030407183700.GB7311@mark.mielke.cc> <3E91C826.8000806@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E91C826.8000806@nortelnetworks.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 02:49:10PM -0400, Chris Friesen wrote:
> Mark Mielke wrote:
> >On Mon, Apr 07, 2003 at 10:19:25AM -0400, Chris Friesen wrote:
> >Chris: Based on your usage patterns, how would Linux know that you were
> >going to be opening up Mozilla, and not that you were going to tweak the
> >kernel source and compile it again?
> Because it would read my mind and figure out what I wanted!   ;-)

Oooo... I want this OS! :-)

> Maybe it would be possible to have some way to tell the kernel, "I would 
> prefer this process to be in memory, unless you're running short, at which 
> point you can swap it out."

> This would be very similar to the niceness value, except it would control 
> what memory gets swapped out.  You could tie it in to what processes have 
> been running, such that if the system goes idle you could start 
> preferentially swapping back in the processes with the memory niceness set. 
> If you left it at zero you get the current behaviour (not swapped in until 
> needed) while positive (or negative, to align with niceness) values would 
> swap that process in preferentially when the system goes idle.

> This would give similar benefits as mlock without actually robbing the 
> kernel of the ability to swap out under memory pressure.

> Does this sound at all useful, or am I blowing smoke?

I think it could be useful, but is probably much more complicated in the
details... Like, for example, how would you know whether a file page in
memory had been used by only one process, or many, and what priority it
should have? What happens if the scheme conflicts with the LRU scheme?
What happens if the memory page is really a shared memory segment used
by both the application and X to double-buffer display the window?

Implementation of this is beyond my imagination today... I only see perils.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

