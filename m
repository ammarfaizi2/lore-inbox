Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276802AbRJCARP>; Tue, 2 Oct 2001 20:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276801AbRJCARF>; Tue, 2 Oct 2001 20:17:05 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:58551 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S276798AbRJCARA>;
	Tue, 2 Oct 2001 20:17:00 -0400
Date: Wed, 3 Oct 2001 02:16:58 +0200
From: David Weinehall <tao@acc.umu.se>
To: Robert Love <rml@tech9.net>
Cc: Christof Efkemann <efkemann@uni-bremen.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Intel 830 support for agpgart
Message-ID: <20011003021658.O7800@khan.acc.umu.se>
In-Reply-To: <20011002033227.6e047544.efkemann@uni-bremen.de> <1001988137.2780.53.camel@phantasy> <20011002151051.488306ee.efkemann@uni-bremen.de> <1002066345.1003.66.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <1002066345.1003.66.camel@phantasy>; from rml@tech9.net on Tue, Oct 02, 2001 at 07:45:42PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2001 at 07:45:42PM -0400, Robert Love wrote:
> On Tue, 2001-10-02 at 09:10, Christof Efkemann wrote:
> > Yes, that seems to work as well.  Although there are two minor things I
> > noticed:
> > - First, intel_generic_setup sets num_aperture_sizes to 7, while the i830
> >   has only 4 valid values (32 to 256 MB).
> > - Second, when intel_generic_configure clears the error status register, it
> >   resets bits 8, 9 and 10.  With an i830 it should clear bits 2, 3 and 4.
> > 
> > So I'm not sure if this works in general, or could it cause errors on other
> > systems?
> 
> It will probably work fine on all systems, but its not the right way to
> go IMO.  Your original implementation was better.
> 
> However, I am still disliking the multiple function idea.  Same thing
> with the i840.  The only real difference is those defines.
> 
> A _very_ simple solution, IF we had separate CONFIG statements for each
> i8xx (or at least one for i830, one for i840, and one for the rest)
> would be:
> 
> /* all the normal defines here */
> #ifdef CONFIG_AGP_I830
> #undef whatever_define_i830_is_different_on
> #define whatever xxx
> /* etc */
> #endif
> #ifdef CONFIG_AGP_I840
> #undef whatever
> #define whatever xxx
> /* etc */
> #endif
> 
> and then, voila, we have but one setup function! we can remove all the
> unique i830 and i840 muck...
> 
> Is seperate config statements a problem?  We already have multiple ones
> for the i810/i815 on/off-board versions...Hmm.

If the only differences between the different cards are the nr of
aperture-sizes and the status-register settings, why not have a struct
which contains all the valid cards, and use a scan-routine?!


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
