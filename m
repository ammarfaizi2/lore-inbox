Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbVKIX3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbVKIX3u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 18:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbVKIX3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 18:29:50 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:43729 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750987AbVKIX3r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 18:29:47 -0500
Date: Wed, 9 Nov 2005 17:29:44 -0600
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Vadim Lobanov <vlobanov@speakeasy.net>,
       "J.A. Magallon" <jamagallon@able.es>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Douglas McNaught <doug@mcnaught.org>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc64-dev@ozlabs.org
Subject: Re: typedefs and structs
Message-ID: <20051109232944.GV19593@austin.ibm.com>
References: <20051108232327.GA19593@austin.ibm.com> <B68D1F72-F433-4E94-B755-98808482809D@mac.com> <20051109003048.GK19593@austin.ibm.com> <m27jbihd1b.fsf@Douglas-McNaughts-Powerbook.local> <20051109004808.GM19593@austin.ibm.com> <19255C96-8B64-4615-A3A7-9E5A850DE398@mac.com> <20051109111640.757f399a@werewolf.auna.net> <Pine.LNX.4.58.0511090816300.4260@shell2.speakeasy.net> <20051109192028.GP19593@austin.ibm.com> <Pine.LNX.4.61.0511091459440.12760@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511091459440.12760@chaos.analogic.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 03:26:10PM -0500, linux-os (Dick Johnson) was heard to remark:
> 
> On Wed, 9 Nov 2005, linas wrote:
> 
> > On Wed, Nov 09, 2005 at 08:22:15AM -0800, Vadim Lobanov was heard to remark:
> >> On Wed, 9 Nov 2005, J.A. Magallon wrote:
> >>
> >>> void do_some_stuff(T& arg1,T&  arg2)
> >>
> >> A diligent C programmer would write this as follows:
> >> 	void do_some_stuff (struct T * a, struct T * b);
> >> So I don't see C++ winning at all here.
> >
> > I guess the real point that I'd wanted to make, and seems
> > to have gotten lost, was that by avoiding using pointers,
> > you end up designing code in a very different way, and you
> > can find out that often/usually, you don't need structs
> > filled with a zoo of pointers.
> 
> But you can't avoid pointers unless you make your entire
> program have global scope. 

I didn't say you can avoid all pointers. I did say that 
for many projects, one can often avoid many pointers.  
And I certainly did not say that one needs global scope 
to do so. In fact, I said the opposite. 

> Also, without pointers, you are severely limited on the kinds
> of libraries you can share. 

I think you don't understand what a reference is. 
A reference is just like a pointer, except that the 
signature is different.  It has nothing to do with the
ability to create or use libraries, or to create/use 
modular code.  

I was trying to say that by focusing on the concept
of a "reference" as opposed to the concept of a 
"pointer", you can write code that is *more* modular, 
not less.

> > Minimizing pointers is good: less ref counting is needed,
> > fewer mallocs are needed, fewer locks are needed
> > (because of local/private scope!!), and null pointer
> > deref errors are less likely.
> 
> No. Minimizing pointers should not be an objective. 

Why not?

I've fixed hundreds of kernel bugs (which you don't 
see on this list because my fixes mostly go to the 
distros or other users) and nine out of ten of these 
are null-pointer derefs. 

Maybe I'm naive for thinking that "fewer pointers == 
fewer pointer bugs" but, hey its worth a shot.

> Properly
> using the components of your tool-set should be. 

What tool set are you refering to?  I am assuming 
that the code is 100% malleable: that one has
complete authority to redesign the way the system 
works, from the ground up.  If you do not have this 
freedom, but are forced to use someone-else's tool set,
then yes, you are SOL.  Furthermore, I would agree 
that mixing two different styles of coding in one 
project can lead to some nasty, ugly code.

> > By using refs instead of pointers, it helps you focus
> > on the issue of "do I really need to store this pointer
> > somewhere? Will I really need it later, or can I be done
> > with it now?".
> 
> Huh? References (at the opcode level) are pointers. There
> is no difference whatsoever. 

Yes, that is right.  I'm not talking about opcodes.
That's not what the conversation is about.

What I am trying to say is that many people design 
code in such a way that they need to store lots of 
pointers in an assortment of structs.

I wanted to emphasize that there are other ways of
designing code, which has smaller needs for pointers
(and that this can be done without loosing modularity,
testability, debugability, and it can be done without 
resorting to global variables.)

--linas




