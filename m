Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291069AbSBGCJu>; Wed, 6 Feb 2002 21:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291072AbSBGCJj>; Wed, 6 Feb 2002 21:09:39 -0500
Received: from age.cs.columbia.edu ([128.59.22.100]:21259 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S291069AbSBGCJe>; Wed, 6 Feb 2002 21:09:34 -0500
Date: Wed, 6 Feb 2002 21:09:25 -0500 (EST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
In-Reply-To: <E16Ydys-0007D6-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0202062101390.4832-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Alan Cox wrote:

> > there is no way to "lose" that data before it hits the wire, unless of
> > course the network driver is broken and doesn't plug the upper layers when
> > its TX queue is full.
> 
> UDP is not flow controlled.

No, of course not, but this has *nothing* to do with UDP. The IP socket 
itself is flow controlled, and so is the TX queue of the network driver.

Let me give you another example: ping -f. If what you said were true, ping -f 
would send packets as fast as the CPU can generate into the black hole 
called an IP raw socket, right? Well, that just doesn't happen, because 
sendto/sendmsg will block until there is enough space in the TX queue of 
the raw socket.

I'll state again: if data (UDP or otherwise) is lost after sendto() 
returns success but before it hits the wire, something is BROKEN in that 
IP stack.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

