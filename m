Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbVKHX55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbVKHX55 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 18:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030426AbVKHX55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 18:57:57 -0500
Received: from smtpout.mac.com ([17.250.248.47]:47341 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1030421AbVKHX54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 18:57:56 -0500
In-Reply-To: <20051108232327.GA19593@austin.ibm.com>
References: <20051105061114.GA27016@kroah.com> <17262.37107.857718.184055@cargo.ozlabs.ibm.com> <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com> <20051107185621.GD19593@austin.ibm.com> <20051107190245.GA19707@kroah.com> <20051107193600.GE19593@austin.ibm.com> <20051107200257.GA22524@kroah.com> <20051107204136.GG19593@austin.ibm.com> <1131412273.14381.142.camel@localhost.localdomain> <20051108232327.GA19593@austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B68D1F72-F433-4E94-B755-98808482809D@mac.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@austin.ibm.com,
       linuxppc64-dev@ozlabs.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: typedefs and structs
Date: Tue, 8 Nov 2005 18:57:11 -0500
To: linas <linas@austin.ibm.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 8, 2005, at 18:23:27, linas wrote:
> Off-topic: There's actually a neat little trick in C++ that can  
> help avoid accidentally passing null pointers.  One can declare  
> function declarations as:
>
>   int func (sturct blah &v) {
>     v.a ++;
>     return v.b;
>   }
>
> The ampersand says "pass argument by reference (so as to get arg  
> passing efficiency) but force coder to write code as if they were  
> passing by value" As a result, it gets difficult to pass null  
> pointers (for reasons similar to the difficulty of passing null  
> pointers in Java (and yes, I loathe Java, sorry to subject you to  
> that))  Anyway, that's a C++ trick  only; I wish it was in C so I  
> could experiment more and find out if I like it or hate it.

That technique tends to cause more problems than it solves.  If I  
write the following code:

struct foo the_leftmost_foo = get_leftmost_foo();
do_some_stuff(the_leftmost_foo);

How do I know what it is going to do?  Will it modify  
the_leftmost_foo, or is it a pass-by-value as it appears?  This is  
just as bad as defining a macro some_macro(foo,bar) that does (foo =  
bar), it's _really_ hard to tell what it does, especially when you  
aren't all that familiar with the code.  A much better solution is this:

void do_some_stuff(struct foo *the_foo) __attribute__((__nonnull__(1)));

do_some_stuff(&the_leftmost_foo);

That ensures that the first argument cannot be explicitly passed as  
null, while still being quite obvious to the programmer what it's doing.

Cheers,
Kyle Moffett

--
They _will_ find opposing experts to say it isn't, if you push hard  
enough the wrong way.  Idiots with a PhD aren't hard to buy.
   -- Rob Landley



