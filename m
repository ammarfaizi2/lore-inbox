Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261663AbREUTzE>; Mon, 21 May 2001 15:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262174AbREUTyy>; Mon, 21 May 2001 15:54:54 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:19471 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261663AbREUTyq>; Mon, 21 May 2001 15:54:46 -0400
Date: 21 May 2001 21:32:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: torvalds@transmeta.com
cc: linux-fsdevel@vger.rutgers.edu
cc: linux-kernel@vger.kernel.org
Message-ID: <81IDi8JHw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.21.0105202005070.8426-100000@penguin.transmeta.com>
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
X-Mailer: CrossPoint v3.12d.kh6 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.LNX.4.21.0105202005070.8426-100000@penguin.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 20.05.01 in <Pine.LNX.4.21.0105202005070.8426-100000@penguin.transmeta.com>:

> If we had nice infrastructure to make ioctl's more palatable, we could
> probably make do even with the current binary-number interfaces, simply
> because people would use the infrastructure without ever even _seeing_ how
> lacking the user-level accesses are.
>
> But that absolutely _requires_ that the driver writers should never see
> the silly "pass a random number and a random argument type" kind of
> interface with no structure or infrastructure in place.

Hmm.

So would it be worthwile to invent some infrastructure - possibly  
including macros, possibly even including a (very small) code generator, I  
don't really have any details clear at this point - that allows you to  
specify an interface in a sane way (for example, but not necessarily, as a  
C function definition, though that may be too hard to parse), and have the  
infrastructure generate

1. some code to call ioctl() with these arguments
2. some other code to pick apart the ioctl buffer and call the actual
   function with these arguments

preferrably so that (a) the code from 1 is suitable for use in libc or  
similar places, (b) the code from 2 is suitable for the kernel, (c) most  
(all would be better but may not be practical) existing ioctls could be  
described that way?

(If so, the first task would obviously be to analyze existing code in  
those places, and the actual structure of existing ioctls, to find out  
what sort of stuff needs to be supported, before trying to design the  
mechanism to support it.)

A variant possibility (that I suspect you'll like significantly less)  
would be a data structure to describe the ioctl that gets interpreted at  
runtime. I think I prefer specific code for that job. At least *some*  
ioctls are in hot spots, and interpreting is slow. And that hypothetical  
encapsulation certainly should not know the difference between fast and  
slow interrupts^Wioctls.

MfG Kai
