Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281504AbRL0VOU>; Thu, 27 Dec 2001 16:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282271AbRL0VOL>; Thu, 27 Dec 2001 16:14:11 -0500
Received: from altus.drgw.net ([209.234.73.40]:14854 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S281805AbRL0VOG>;
	Thu, 27 Dec 2001 16:14:06 -0500
Date: Thu, 27 Dec 2001 15:13:19 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011227151319.E25200@altus.drgw.net>
In-Reply-To: <Pine.LNX.4.33L.0112271802130.12225-100000@duckman.distro.conectiva> <Pine.LNX.4.33.0112271210250.1167-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112271210250.1167-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Dec 27, 2001 at 12:12:54PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 12:12:54PM -0800, Linus Torvalds wrote:
> 
> On Thu, 27 Dec 2001, Rik van Riel wrote:
> > > came out, and emailed me when the patch no longer applies.
> >
> > ... or compiles, or applies with an offset
> 
> Good.
> 
> We actually talked inside Transmeta about doing a lot of this automation
> centralized (and OSDL took up some of that idea), but yes, from a resource
> usage sanity standpoint this is something that _trivially_ can be done at
> the sending side, and thus scales out perfectly (while trying to do it at
> the receiving end requires some _mondo_ hardware that definitely doesn't
> scale, especially for the "compiles cleanly" part).

So here's an idea:

Maintainers for a specific area of interest/kernel tree/whatever can run a
'canned' set of scripts on a web server which act as a controller for a
patchbot, and a set of 'build machines' that actually do the compiles.

(i.e., davej, andrea, riel, etc would have their own webserver which 
acts as a central location for data collection, as well as a place for 
users to download stuff from)

Actually compiling gets done either by users that want to use that kernel,
or in the case of a vendor, an internal build farm. The users have another
'canned' script that downloads the kernel, patches it, and builds it with
a user-supplied or server-supplied config file. The script uploads the
results of the build so maintainers can see what happened, and the web
server provides some mechanism for users to say what did and did not work.

Once the webserver gets some data back, the patchbot can figure out 
whether a particular patch was a 'success' or not, and decide whether to 
send it, dequeue it, or whatever.

We should probably also add the ability for end-users to submit their own 
patches to a maintainer, or provide a way for end-users to setup the 
webserver system so they can do the same thing the maintainers are doing.


The most important part here is that this system has to be less work for 
maintainers than it is responding to hundreds of emails and checking if a 
patch made it in all the time. (I think this should be relatively easy). 
It's got to be easy to set up, both for maintainers and users.


I've got some reasonably nice python scripts that currently act as the 
'build system' part of this, and some somewhat ugly scripts that run on a 
webserver. A brief description is available here.
 
http://altus.drgw.net/description.html

I'll volunteer these scripts as well as whatever amount of time I can 
spare from 'real' work ;)

Does anyone else this discussion merits it's own mailing list.. ?

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
