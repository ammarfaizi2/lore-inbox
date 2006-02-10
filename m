Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWBJSsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWBJSsH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 13:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWBJSsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 13:48:07 -0500
Received: from eastrmmtao01.cox.net ([68.230.240.38]:60855 "EHLO
	eastrmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750734AbWBJSsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 13:48:05 -0500
Date: Fri, 10 Feb 2006 13:48:04 -0500
From: Chris Shoemaker <c.shoemaker@cox.net>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, tytso@mit.edu,
       peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060210184804.GA27917@pe.Belkin>
References: <43EC8E18.nailISDJTQDBG@burner> <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr> <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org> <43ECA3FC.nailJGC110XNX@burner> <43ECA70C.8050906@nortel.com> <43ECA8BC.nailJHD157VRM@burner> <43ECADA8.9030609@nortel.com> <20060210153223.GA27599@pe.Belkin> <43ECB701.1010703@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ECB701.1010703@nortel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 09:53:37AM -0600, Christopher Friesen wrote:
> Chris Shoemaker wrote:
> >On Fri, Feb 10, 2006 at 09:13:44AM -0600, Christopher Friesen wrote:
> 
> >>That depends on what "uniquely identified" actually means.
> >
> >
> >"The st_ino and st_dev fields taken together uniquely identify the
> >file within the system."
> 
> >>The other possibility (and this is what you seem to be advocating) is 
> >>that a st_ino/st_dev tuple always maps to the same file over the entire 
> >>runtime of the system.
> 
> >However, I don't think this is a reasonable interpretation, and it's
> >clearly _not_ the one that Joerg is implying.
> >
> >Joerg is claiming that the quoted sentence also implies that
> >_different_ st_ino/st_dev pairs will _always_ identify different
> >files.  Taken in just the immediate context of stat.h, this is a
> >very reasonable interpretation.
> 
> It seems to me that "st_ino/st_dev tuple always maps to the same file" 
> is equivalent to "different st_ino/st_dev pairs will always identify 
> different files".  What is the distinction between the two statements?

This distinction is probably quite important.  

The first assertion is that this is an injective mapping from the
domain of files to the range of st_Ito/st_dev pairs.

The second assertion is that this is an injective mapping from the
domain of st_Ito/st_dev pairs to the range of files.

The first may be true even when the second is false.

I'm no expert on SUS, but if a spec says "X uniquely identifies Y"
it's almost certainly asserting that there's an injective mapping from
the domain of X into the domain of Y, and it's probably also
reasonable to infer that the mapping in the other direction is also
injective.

> As I see it, the main question is whether it is a unique mapping *at one 
> specific point in time*, or is it a unique mapping *for the duration of 
> the system*?  Note that in this case "system" includes "parts of the 
> tree that may be remotely mounted from other machines on the network".
> 
> I would suggest that the spec doesn't specify the duration of the unique 
> mapping, and thus as long as there is a unique mapping *at any 
> particular point in time*, then there is no conflict.

In the absense of a specified duration for which the property must
hold, it's unfortunately necessary (albeit, somewhat dangerous) to
*infer* the duration based on the intended *use* of the property
(e.g. equality testing).  Two parties which intend to employ the
property for different purposes may infer two different durations - a
typical spec deficiency.

> If we read it as requiring a unique mapping for the duration of the 
> system, consider a hypothetical "system" that includes all the devices 
> of all the computers on the planet, and they are all dynamically 
> appearing and disappearing continuously.  Consider the technical 
> challenge in ensuring that each file on this hypothetical system is 
> permanently and uniquely identified by a device/nod pair.

It seems this example only presents a challenge to ensuring the
*inferred* requirement of the injective mapping from files to pairs,
not for ensuring *only* the explicit requirement that pairs uniquely
identify a file (but not necessarily that they uniquely identify *one*
file).

-chris
