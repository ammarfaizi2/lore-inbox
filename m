Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263586AbTDGSh6 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 14:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTDGSh6 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 14:37:58 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:28596 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263586AbTDGSh4 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 14:37:56 -0400
Message-ID: <3E91C826.8000806@nortelnetworks.com>
Date: Mon, 07 Apr 2003 14:49:10 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Schlichter <schlicht@rumms.uni-mannheim.de>,
       linux-kernel@vger.kernel.org
Subject: Re: An idea for prefetching swapped memory...
References: <200304071026.47557.schlicht@uni-mannheim.de> <200304072021.17080.kernel@kolivas.org> <1049712476.3e91575c2e6ae@rumms.uni-mannheim.de> <3E917BFA.4020303@aitel.hist.no> <3E9188ED.1090109@nortelnetworks.com> <20030407183700.GB7311@mark.mielke.cc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:
> On Mon, Apr 07, 2003 at 10:19:25AM -0400, Chris Friesen wrote:

> Chris: Based on your usage patterns, how would Linux know that you were
> going to be opening up Mozilla, and not that you were going to tweak the
> kernel source and compile it again?

Because it would read my mind and figure out what I wanted!   ;-)

Maybe it would be possible to have some way to tell the kernel, "I would prefer 
this process to be in memory, unless you're running short, at which point you 
can swap it out."

This would be very similar to the niceness value, except it would control what 
memory gets swapped out.  You could tie it in to what processes have been 
running, such that if the system goes idle you could start preferentially 
swapping back in the processes with the memory niceness set.  If you left it at 
zero you get the current behaviour (not swapped in until needed) while positive 
(or negative, to align with niceness) values would swap that process in 
preferentially when the system goes idle.

This would give similar benefits as mlock without actually robbing the kernel of 
the ability to swap out under memory pressure.

Does this sound at all useful, or am I blowing smoke?

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

