Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263411AbRFAIQg>; Fri, 1 Jun 2001 04:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263413AbRFAIQ0>; Fri, 1 Jun 2001 04:16:26 -0400
Received: from hera.cwi.nl ([192.16.191.8]:34788 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263411AbRFAIQQ>;
	Fri, 1 Jun 2001 04:16:16 -0400
Date: Fri, 1 Jun 2001 10:16:14 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106010816.KAA162273.aeb@vlet.cwi.nl>
To: dean-list-linux-kernel@arctic.org, jcwren@jcwren.com
Subject: Re: select() - Linux vs. BSD
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    On Tue, 29 May 2001, John Chris Wren wrote:

    >     In BSD, select() states that when a time out occurs,
    >     the bits passed to select will not be altered.
    >     In Linux, which claims BSD compliancy for this
    >     in the man page (but does not state either way
    >     what will happen to the bits), zeros the users bit masks
    >     when a timeout occurs.

(i) "In BSD" - which one did you look at? 4.2? 4.3? 4.4?
Details differ a bit.

(ii) The Linux man page only says

RETURN VALUE
       On  success,  select  and  pselect  return  the  number of
       descriptors contained in the descriptor sets, which may be
       zero  if  the  timeout expires before anything interesting
       happens.  On error, -1  is  returned,  and  errno  is  set
       appropriately;  the  sets and timeout become undefined, so
       do not rely on their contents after an error.
	
That is, a wise programmer does not assume any particular value
for the bits after a timeout.

    >     Should the man pages be changed to reflect reality,

They do reflect reality.

    > or select() fixed to act like BSD?

No, select() is fine.


dean gaudet answered:

    sounds like a man page bug.

Shame on him for noticing man page bugs without cc'ing
the man page maintainer! Fortunately however, I do not
think anything is wrong here. But just to be sure I added
a sentence to select.2:

  On BSD, when a timeout occurs, the file descriptor bits are not changed.
  Linux follows SUSv2 and sets the bit masks to zero upon a timeout.

Andries
