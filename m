Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286804AbRL1Jt5>; Fri, 28 Dec 2001 04:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286803AbRL1Jtq>; Fri, 28 Dec 2001 04:49:46 -0500
Received: from pcow035o.blueyonder.co.uk ([195.188.53.121]:52491 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S286795AbRL1Jtd>;
	Fri, 28 Dec 2001 04:49:33 -0500
Message-ID: <T5819437331ac1785ed279@pcow035o.blueyonder.co.uk>
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <james@sutherland.net>
To: Dave Jones <davej@suse.de>
Subject: Re: [RFC][PATCH] unchecked request_region's in drivers/net
Date: Fri, 28 Dec 2001 09:50:07 +0000
X-Mailer: KMail [version 1.3.1]
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Steven Walter <srwalter@yahoo.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0112280027541.15706-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.33.0112280027541.15706-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 December 2001 11:40 pm, Dave Jones wrote:
> On Thu, 27 Dec 2001, James A Sutherland wrote:
> > I'd add one level of abstraction: have each filename map to a "module"
> > name. In this case, each filename relating to devfs would map to module
> > "devfs"; there would then be an entry mapping devfs <-> Richard.
> > (Perhaps a hierarchy - fs.devfs - with people like Al listed for "fs"?)
>
> Could work, but there are some bits that have no maintainer as such,
> eg, the pci irq routing. There have been several interested parties
> hacking on it however. A means of having people add themselves to the
> list would be a 'must have' feature.

Yes. Something like mailman's approach, perhaps? (You set a password when you 
subscribe, then you can see and change which modules you are subscribed to 
using that password.)

> > It should be a little easier having a mapping to a module - in most
> > cases, there's a clear "module" to which each file belongs. Then just
> > track who's "subscribed to" that module...
>
> Having a mapping from kernel source filename -> email address would
> still be preferred personally.

You would still have that feature: my script was intended to take patches, 
filenames or modulenames as input, and list the interested parties and/or 
module names.

So...

$ cclist -m big_patch
fs/devfs
arch/x86

$ cclist -f fs/devfs/base.c
Richard Gooch <...>
Al Viro <...>

> $ cclist devfs
>
> is really not much of an improvement over
>
> $ grep -C3 -i devfs MAINTAINERS
>
> Other than the addition of extra 'interested, cc me too' people.

And tracking of filename<->module relationships, allowing you to look up who 
would be interested in a given patch.

> The only problem with my original idea is that its a pita to keep
> up to date. kernel files get added and removed on a weekly (sometimes
> daily) basis. Whoever is dumb^Wwonderful enough to volunteer to
> maintain such a database is likely to have their work cut out for
> them, so maybe your module idea is preferable.

In the way I'm suggesting, it just simplifies matters a little: rather than 
having to list RG and AV separately for every single file in devfs, just say 
"this new file is part of devfs" and it "inherits" them that way.


James.
