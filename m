Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272360AbRHYAZg>; Fri, 24 Aug 2001 20:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272361AbRHYAZ0>; Fri, 24 Aug 2001 20:25:26 -0400
Received: from web10903.mail.yahoo.com ([216.136.131.39]:50700 "HELO
	web10903.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S272360AbRHYAZM>; Fri, 24 Aug 2001 20:25:12 -0400
Message-ID: <20010825002528.2202.qmail@web10903.mail.yahoo.com>
Date: Fri, 24 Aug 2001 17:25:28 -0700 (PDT)
From: Brad Chapman <kakadu_croc@yahoo.com>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0108242002130.19796-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Alexander Viro <viro@math.psu.edu> wrote: 
> On Fri, 24 Aug 2001, Brad Chapman wrote:
> 
> > 	- make everyone use the new macros (some people are thinking :P)
> > 
> > 	- make everyone use #ifdef blocks with a config option (you think it's :P)
> > 
> > 	- make min()/max() typeof() wrappers for a switch-style stack of comparison 
> > 	  functions which work on the various types, i.e:
> > 	
> > 	  __u8 minimum = min(one, two) -> __u8 minimum = __u8_min(one, two)
> > 
> > 	  (this may be too complex and is probably :P) 
> > 
> > 	- make min()/max() inline functions, cast things to void, and use memcmp()
> > 	  (this might almost be reasonable, but is probably also :P)
> > 
> > 	- stay with the old-style macros (:P, :P, :P)
> > 
> > 	What do you think, sir?
> 
> 	Use different inline functions for signed and unsigned.
> Explicitly.

	OK. That sounds reasonable, but do we want to do another forced
change, or do we want to hide it? That seems to be the root of the problem:
keeping the same API but making it work _right_.

> 
> 	Any scheme trying to imitate polymorphism with use of cpp/
> GNU extensions/whatever is missing the point.  There is _no_ common
> operation to extend on several types.  Choice between signed and
> unsigned max should be explicit - they are different operations.

	Well, IIRC I remember someone saying that it was legal to compare
signed/unsigned ints, if you did it in the right order. IMHO that might be
incorrect. And none of the ideas I have suggested use any fancy cpp/GNU rubbish.
The most evil-sounding thing I suggested was #4.

> 
> 	Trying to hide that is C++itis of the worst kind - false
> polymorphism that hides only one thing: subtle bugs.
>

	Ack. (IMHO) I don't like C++ either :P

Brad 


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com
Current e-mail: kakadu@adelphia.net
Alternate e-mail: kakadu@netscape.net

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
