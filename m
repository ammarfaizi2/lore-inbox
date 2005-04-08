Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVDHXrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVDHXrV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 19:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVDHXrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 19:47:21 -0400
Received: from adsl-69-233-54-142.dsl.pltn13.pacbell.net ([69.233.54.142]:50184
	"EHLO bastard.smallmerchant.com") by vger.kernel.org with ESMTP
	id S261199AbVDHXrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 19:47:16 -0400
Message-ID: <425717CB.6020405@tupshin.com>
Date: Fri, 08 Apr 2005 16:46:19 -0700
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <1112858331.6924.17.camel@localhost.localdomain> <Pine.LNX.4.58.0504070810270.28951@ppc970.osdl.org> <Pine.LNX.4.61.0504072318010.15339@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0504072318010.15339@scrub.home>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:

>Preserving the complete merge history does indeed make repeated merges 
>simpler, but it builds up complex meta data, which has to be managed 
>forever. I doubt that this is really an advantage in the long term. I 
>expect that we were better off serializing changesets in the main 
>repository. For example bk does something like this:
>
>	A1 -> A2 -> A3 -> BM
>	  \-> B1 -> B2 --^
>
>and instead of creating the merge changeset, one could merge them like 
>this:
>
>	A1 -> A2 -> A3 -> B1 -> B2
>
>This results in a simpler repository, which is more scalable and which 
>is easier for users to work with (e.g. binary bug search).
>The disadvantage would be it will cause more minor conflicts, when changes 
>are pulled back into the original tree, but which should be easily 
>resolvable most of the time.
>
Both darcs and arch (and arch's siblings) have ways of maintaining the 
complete history but speeding up operations.

Arch use's revision libraries:
http://www.gnu.org/software/gnu-arch/tutorial/revision-libraries.html
though i'm not all that up on arch so I'll just leave it at that.

Darcs uses "darcs optimize --checkpoint"
http://darcs.net/manual/node7.html#SECTION00764000000000000000
which "allows for users to retrieve a working repository with limited 
history with a savings of disk space and bandwidth." In darcs case, you 
can pull a partial repository by doing "darcs get --partial", in which 
case you only grab the state at the point that the repository was 
optimized and subsequent patches, and all operations only need to work 
against the set of patches since that optimize.

Note, that I'm not promoting darcs for kernel usage because of speed (or 
the lack thereof) but I am curious why Linus would consider monotone 
given its speed issues but not consider darcs.

-Tupshin
