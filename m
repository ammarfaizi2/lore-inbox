Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289426AbSAJMhe>; Thu, 10 Jan 2002 07:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289428AbSAJMhZ>; Thu, 10 Jan 2002 07:37:25 -0500
Received: from maild.telia.com ([194.22.190.101]:28393 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S289426AbSAJMhQ>;
	Thu, 10 Jan 2002 07:37:16 -0500
Date: Thu, 10 Jan 2002 13:37:11 +0100
From: Erik Trulsson <ertr1013@student.uu.se>
To: dewar@gnat.com
Cc: Dautrevaux@microprocess.com, pkoning@equallogic.com, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, mrs@windriver.com
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020110123711.GA745@student.uu.se>
Mail-Followup-To: dewar@gnat.com, Dautrevaux@microprocess.com,
	pkoning@equallogic.com, gcc@gcc.gnu.org,
	linux-kernel@vger.kernel.org, mrs@windriver.com
In-Reply-To: <20020110121845.91AD8F317E@nile.gnat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020110121845.91AD8F317E@nile.gnat.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 07:18:45AM -0500, dewar@gnat.com wrote:
> <<Note that this is not too much of a problem for system programming, as you
> have a way to be sure they are not combined: just use intermediate variables
> and set them separately; the nice thing there is that as you use these
> intermediate variables just once, the compiler will eliminate them. But be
> careful: the sequence point MUST BE RETAINED, and then the two loads cannot
> be combined (in case 1 of course).
> >>
> 
> Of course we all understand that sequence points myust be retained, but this
> is a weak condition compared to the rule that all loads and stores for
> volatile variables must not be resequenced, and in particular, you seem to
> agree that two loads *can* be combined if they both appear between two
> sequence points. I think that's unfortunate, and it is why in Ada we
> adopted a stricter point of view that avoids the notion of sequence points.
> 
> It even seems that if you have two stores between two sequence points then
> the compiler is free to omit one, and again that seems the wrong decision
> for the case of volatile variables. If it can omit a store in this way, can
> it omit a load, i.e. if we have:
> 
>    x := v - v;
> 
> can someone read the sequence point rule to mean that the compiler is
> free to do only one load here? I hope not, but we have already seen how
> much confusion there is on this point.

The compiler is not free to do only one load there if v is declared
volatile.
The relevant part of the C standard would be the following paragraph:

[6.7.3]
       [#6] An object  that  has  volatile-qualified  type  may  be
       modified in ways unknown to the implementation or have other
       unknown side effects.  Therefore any expression referring to
       such  an object shall be evaluated strictly according to the
       rules of the abstract  machine,  as  described  in  5.1.2.3.
       Furthermore,  at  every sequence point the value last stored
       in the object  shall  agree  with  that  prescribed  by  the
       abstract  machine, except as modified by the unknown factors
       mentioned previously.105)  What constitutes an access to  an
       object  that  has volatile-qualified type is implementation-
       defined.


footnote 105:

       105A volatile declaration may be used to describe an  object
          corresponding  to a memory-mapped input/output port or an
          object  accessed  by   an   asynchronously   interrupting
          function.   Actions  on  objects so declared shall not be
          `optimized  out''  by  an  implementation  or  reordered
          except   as   permitted   by  the  rules  for  evaluating
          expressions.


[Quotes taken from a draft of the final standard, so it is possible,
but unlikely, that this was changed for the final standard.]

-- 
<Insert your favourite quote here.>
Erik Trulsson
ertr1013@student.uu.se
