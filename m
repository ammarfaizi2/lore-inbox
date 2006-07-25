Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWGYO3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWGYO3i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 10:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWGYO3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 10:29:38 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:53970 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S932363AbWGYO3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 10:29:37 -0400
Message-ID: <44C62A08.5060203@s5r6.in-berlin.de>
Date: Tue, 25 Jul 2006 16:26:16 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: Matt LaPlante <kernel1@cyberdogtech.com>, linux-kernel@vger.kernel.org
Subject: Re: Question about Git tree methodology.
References: <20060724163145.5819ce7d.kernel1@cyberdogtech.com> <44C53323.2030905@gentoo.org>
In-Reply-To: <44C53323.2030905@gentoo.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Matt LaPlante wrote:
[...]
>> Basically I just want to use it as a method of tracking my own
>> trivial patches (and perhaps give maintainers easier access to them).
> 
> Quilt is very good at doing this kind of thing.
> http://savannah.nongnu.org/projects/quilt

Introductory documentation:
http://cvs.savannah.nongnu.org/viewcvs/*checkout*/quilt/doc/quilt.pdf?root=quilt

> It keeps all your patches in a "patches" subdirectory and makes going 
> back and fixing previous patches very easy (git makes this quite hard). 
> You can rsync your patches/ directory to any webserver, and anyone else 
> can save them in a patches subdirectory and apply them in the same way 
> (the equivalent of sharing your tree).

Hi Matt,

yes, Quilt is a good tool especially for maintenance of patch
collections on top of evolving source trees. I for one use it to keep
track of patches for the subsystem of my interest (ieee1394 drivers), to
develop new patches asynchronously to mainline releases, and to publish
'backports': http://me.in-berlin.de/~s5r6/linux1394/updates/

The "patches" subdirectories at this site is what quilt itself is
working on. Examples of basic tasks are
$ quilt import   # add a foreign patchfile to quilt's collection
$ quilt push     # apply next patch listed in patches/series
$ quilt pop      # unapply current patch
$ quilt refresh  # regenerate the diff of the current patch after the
                   sources have been edited or otherwise changed

To submit patches to maintainers, either post them with your usual mail
user agent or let "quilt mail ..." prepare the postings or --- as Daniel
wrote --- publish them on a server. In the latter case, take care to
prepend mbox-like headers (especially a "From: " header to denote the
patch's author) so that git users can import those patchfiles easily
with "git am". (The patches on my site still lack those headers because
I rarely forward patches from other authors.)

There are things that Quilt does _not_ do for you:
 - update the underlying source tree from other repos
 - generate changelogs (I wrote a simple script around Quilt to generate
   the changelogs at my site. But that script is quite slow if it has to
   handle a bigger number of patches.)
 - certainly a few other things which Quilt wasn't intended for...

If you plan to intensively interact with git trees, StGIT ("Stacked GIT"
 alias "stg") may also be worth a look: http://www.procode.org/stgit/
I haven't tried StGIT myself yet. AFAICS it provides basically the same
functions as Quilt with two apparent differences:
 - The three steps to update the underlying source tree "quilt pop -a;
   git pull ...; quilt push -a" are available as a single command:
   "stg pull ...". Big deal.
 - The steps to commit your patches into the underlying git tree are
   easily performed by "stg commit".
After a patch was committed to the git tree, you loose the ability to
modify the patch as freely as you could while it was managed by quilt or
StGIT.

To summarize, Quilt or StGIT are a good choice if you plan to develop or
maintain patches which you want to change (update, improve...) in a
different rhythm than the underlying source tree. This is what many
"upstream developers" as well as "downstream distributors" do. Upstream
developers may need to update their patches sometimes a few times before
final submission, e.g. based on change requests from reviewers, or
because the order of patches is to be changed to submit newer critical
patches before older but less critical patches. Downstream distributors
maintain add-ons (e.g. out-of-tree feature patches, customizations,
backported bug fixes) on top of a source tree from upstream.
-- 
Stefan Richter
-=====-=-==- -=== ==---
http://arcgraph.de/sr/
