Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbVKMAuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbVKMAuV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 19:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbVKMAuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 19:50:21 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:12013
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S964901AbVKMAuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 19:50:19 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: Why did oldconfig's behavior change in 2.6.15-rc1?
Date: Sat, 12 Nov 2005 18:50:01 -0600
User-Agent: KMail/1.8
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
References: <200511121656.29445.rob@landley.net> <200511121731.25982.rob@landley.net> <Pine.LNX.4.61.0511130042530.1610@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0511130042530.1610@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511121850.01690.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 November 2005 17:49, Roman Zippel wrote:
> Hi,
>
> On Sat, 12 Nov 2005, Rob Landley wrote:
> > Why did oldconfig switch off CONFIG_MODE_SKAS?  It didn't do that before.
> > Hmmm...  Rummage, rummage...  Darn it, it's position dependent.  _And_
> > version dependent.
>
> It's _not_ position dependent, but the behaviour with multiple equal
> symbols is undefined.

I just want a minimally expressed config.  I've jumped through a number of 
hoops trying to get "allnoconfig plus these symbols" to work.

Setting .config to my symbol list and doing old config prompts a lot, doing 
yes "" | oldconfig sets lots of crap by default (since not all default values 
are n), and doing yes "n" | oldconfig goes into an endless loop every time 
it's prompting for a number or some such.  You have to start with 
allnoconfig.  Appending the new symbols and re-running oldconfig worked for a 
number of versions, until now.  Now you have to insert the new symbols at the 
beginning.

I could presumably also work around the new breakage via following allnoconfig 
with a sed -i invocation to remove the appropriate "# blah is not set" lines 
before appending the symbols.  (Of course it means that the config symbol 
list has to be fed into a for loop instead of being expressed in the same 
format as config, which sucks deeply.  Insert at the beginning works until it 
changes again...)

> > Ok, now I have to put the new entries at the _beginning_.  Appending them
> > doesn't work anymore, it now ignores any symbol it's already seen, so you
> > can't easily start with allnoconfig, switch on just what you want, and
> > expect oldconfig to do anything intelligent.
>
> Now you can put them in allno.config instead and allnoconfig will do the
> right thing.

Testing...

Ok, that worked.  Weird and totally unituitive name for a miniconfig, but oh 
well.

Is this documented anywhere?

Rob
