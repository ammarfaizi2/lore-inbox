Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317786AbSGKR7G>; Thu, 11 Jul 2002 13:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317808AbSGKR7F>; Thu, 11 Jul 2002 13:59:05 -0400
Received: from pD952A525.dip.t-dialin.net ([217.82.165.37]:63617 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317786AbSGKR7E>; Thu, 11 Jul 2002 13:59:04 -0400
Date: Thu, 11 Jul 2002 12:01:25 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Roman Zippel <zippel@linux-m68k.org>
cc: Daniel Phillips <phillips@arcor.de>, Rusty Russell <rusty@rustcorp.com.au>,
       Alexander Viro <viro@math.psu.edu>,
       "David S. Miller" <davem@redhat.com>, <adam@yggdrasil.com>,
       <R.E.Wolff@bitwizard.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: Rusty's module talk at the Kernel Summit
In-Reply-To: <Pine.LNX.4.44.0207111929500.8911-100000@serv>
Message-ID: <Pine.LNX.4.44.0207111158160.3582-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 11 Jul 2002, Roman Zippel wrote:
> On Thu, 11 Jul 2002, Daniel Phillips wrote:
> > Closing the rmmod race with this interface is easy.  We can for example just
> > keep a state variable in the module struct (protected by a lock) to say the
> > module is in the process of being deregistered.
> 
> Please check try_inc_mod_count(). It's already done.

Btw, couldn't the module/non-module issue be solved like this:

int module_do_blah(struct blah *blah, didel_t dei)
#ifdef __MODULE__
{
	locking_code();
	pure_module_do_blah(blah, dei)
	unlocking_code();
}

int pure_module_do_blah(struct blah *blah, didel_t dei)
#endif /* __MODULE__ */

Just an idea...

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

