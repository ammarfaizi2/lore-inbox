Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276795AbRJBXp3>; Tue, 2 Oct 2001 19:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276796AbRJBXpT>; Tue, 2 Oct 2001 19:45:19 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:7225 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S276795AbRJBXpN>; Tue, 2 Oct 2001 19:45:13 -0400
Subject: Re: [PATCH] Intel 830 support for agpgart
From: Robert Love <rml@tech9.net>
To: Christof Efkemann <efkemann@uni-bremen.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011002151051.488306ee.efkemann@uni-bremen.de>
In-Reply-To: <20011002033227.6e047544.efkemann@uni-bremen.de>
	<1001988137.2780.53.camel@phantasy> 
	<20011002151051.488306ee.efkemann@uni-bremen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.30.08.08 (Preview Release)
Date: 02 Oct 2001 19:45:42 -0400
Message-Id: <1002066345.1003.66.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-10-02 at 09:10, Christof Efkemann wrote:
> Yes, that seems to work as well.  Although there are two minor things I
> noticed:
> - First, intel_generic_setup sets num_aperture_sizes to 7, while the i830
>   has only 4 valid values (32 to 256 MB).
> - Second, when intel_generic_configure clears the error status register, it
>   resets bits 8, 9 and 10.  With an i830 it should clear bits 2, 3 and 4.
> 
> So I'm not sure if this works in general, or could it cause errors on other
> systems?

It will probably work fine on all systems, but its not the right way to
go IMO.  Your original implementation was better.

However, I am still disliking the multiple function idea.  Same thing
with the i840.  The only real difference is those defines.

A _very_ simple solution, IF we had separate CONFIG statements for each
i8xx (or at least one for i830, one for i840, and one for the rest)
would be:

/* all the normal defines here */
#ifdef CONFIG_AGP_I830
#undef whatever_define_i830_is_different_on
#define whatever xxx
/* etc */
#endif
#ifdef CONFIG_AGP_I840
#undef whatever
#define whatever xxx
/* etc */
#endif

and then, voila, we have but one setup function! we can remove all the
unique i830 and i840 muck...

Is seperate config statements a problem?  We already have multiple ones
for the i810/i815 on/off-board versions...Hmm.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

