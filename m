Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272351AbRHYANq>; Fri, 24 Aug 2001 20:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272352AbRHYANg>; Fri, 24 Aug 2001 20:13:36 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:47262 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S272351AbRHYAN3>;
	Fri, 24 Aug 2001 20:13:29 -0400
Date: Fri, 24 Aug 2001 20:13:44 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Brad Chapman <kakadu_croc@yahoo.com>
cc: Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <20010824235858.59972.qmail@web10908.mail.yahoo.com>
Message-ID: <Pine.GSO.4.21.0108242002130.19796-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Aug 2001, Brad Chapman wrote:

> 	- make everyone use the new macros (some people are thinking :P)
> 
> 	- make everyone use #ifdef blocks with a config option (you think it's :P)
> 
> 	- make min()/max() typeof() wrappers for a switch-style stack of comparison 
> 	  functions which work on the various types, i.e:
> 	
> 	  __u8 minimum = min(one, two) -> __u8 minimum = __u8_min(one, two)
> 
> 	  (this may be too complex and is probably :P)

> 
> 	- make min()/max() inline functions, cast things to void, and use memcmp()
> 	  (this might almost be reasonable, but is probably also :P)
> 
> 	- stay with the old-style macros (:P, :P, :P)
> 
> 	What do you think, sir?

	Use different inline functions for signed and unsigned.
Explicitly.

	Any scheme trying to imitate polymorphism with use of cpp/
GNU extensions/whatever is missing the point.  There is _no_ common
operation to extend on several types.  Choice between signed and
unsigned max should be explicit - they are different operations.

	Trying to hide that is C++itis of the worst kind - false
polymorphism that hides only one thing: subtle bugs.

