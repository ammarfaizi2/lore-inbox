Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266854AbSKUQsi>; Thu, 21 Nov 2002 11:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266868AbSKUQsh>; Thu, 21 Nov 2002 11:48:37 -0500
Received: from auto-matic.ca ([216.209.85.42]:52997 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S266854AbSKUQsg>;
	Thu, 21 Nov 2002 11:48:36 -0500
Date: Thu, 21 Nov 2002 12:02:24 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       David McIlwraith <quack@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: spinlocks, the GPL, and binary-only modules
Message-ID: <20021121170224.GB5315@mark.mielke.cc>
References: <1037875005.1863.0.camel@localhost.localdomain> <Pine.LNX.4.10.10211210503090.3892-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10211210503090.3892-100000@master.linux-ide.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 05:08:45AM -0800, Andre Hedrick wrote:
> On 21 Nov 2002, Arjan van de Ven wrote:
> > It is if the AUTHOR then decides to distribute the resulting binary
> > which would contain a mix of GPL and non GPL work..
> The mix is a direct result of developers knowingly inlining critical C
> code into the headers.  If this code was placed in proper .c files and not
> set in a .h then the potential for accidental mixing is removed.
> This would limit and restrict the headers to being structs and extern
> functions to call.

Some (not all) of the inlined functions are 'inline' to accelerate the
kernel.

Perhaps, though, the inlined functions should be declared:

   #ifdef __GNUC__
   #  define INLINE extern inline
   #else
   #  define INLINE inline
   #endif

   #ifdef GPL
   INLINE type function (arguments)
   {
      ...
   }
   #else
   INLINE type function (arguments);
   #endif

This would be neat in that no real additional code would be brought into
the module, however, there is a possibility that the module would run a little
bit slower - a small incentive to GPL the module...

Of course, this would mean that any #define's still sitting around that
contributed code of significance should be replaced with possibly inlined
functions...

Would this make everybody happy?

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

