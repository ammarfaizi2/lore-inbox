Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbVDXURi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbVDXURi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 16:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVDXURi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 16:17:38 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6100 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262399AbVDXURc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 16:17:32 -0400
Date: Sun, 24 Apr 2005 22:17:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, drzeus-list@drzeus.cx, torvalds@osdl.org,
       pasky@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050424201708.GA30088@elf.ucw.cz>
References: <20050422231839.GC1789@elf.ucw.cz> <Pine.LNX.4.58.0504221718410.2344@ppc970.osdl.org> <20050423111900.GA2226@openzaurus.ucw.cz> <Pine.LNX.4.58.0504230654190.2344@ppc970.osdl.org> <426A7775.60207@drzeus.cx> <20050423220213.GA20519@kroah.com> <20050423222946.GF1884@elf.ucw.cz> <20050423233809.GA21754@kroah.com> <20050424032622.3aef8c9f.akpm@osdl.org> <20050424195554.GA2857@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050424195554.GA2857@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > Greg KH <greg@kroah.com> wrote:
> > > In the patches/ subdir below that one, is a mirror of my quilt patches
> > > directory, series file and all.  That way people can still see the
> > > individual patches if they want to.
> > > 
> > > Does this help some?  It's all still under flux as to how this all
> > > works, try something and go from there :)
> > 
> > Yes, it would be nice to have gregkh's patches in -mm as individual patches.
> 
> It would?  Ok, that's easy to change.
> 
> > Of course, whatever gets done, I'd selfishly prefer that most (or even all)
> > subsystem maintainers work the same way and adopt the same work practices.
> > 
> > I guess it's too early to think about that, but if one maintainer (hint)
> > were to develop and document a good methodology and toolset, others might
> > quickly follow.
> 
> Heh, ok, I can take a hint, I'll work on this this week.  I already have
> the "export a series of patches from a git tree that are not in another
> git tree" working, so it shouldn't be tough to get the rest in an
> "automated" manner.

I started to do something like that, but got to dead end (shared
object directories...). Maybe this is usefull to someone, and maybe
not...

								Pavel

	Kernel hacker's guide to git
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      2005 Pavel Machek <pavel@suse.cz>

You can get git at http://pasky.or.cz/~pasky/dev/git/ . Compile it,
and place it somewhere in $PATH. Then you can get kernel by running

mkdir clean-git; cd clean-git
git init rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

... Run git log to get idea of what happened in tree you are
tracking. Do git pull linus to pickup latest changes from Linus. You
can do git diff to see what changes you done in your local tree. git
cancel will kill any such changes.

You can commit changes by doing git commit... If you want to get diff
of your changes against mainline, do

git diff -r origin: 

. If you want to get the same diff but separated patch-by-patch, do

git patch origin:

. (Does something unexpected after first merge).

To update your tree against name "foo", do:

        git track linus
        git pull

or

        git merge linus


How to set up your trees so that you can cooperate with linus
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

What I did:

Created clean-git. Initialized straight from Linus (as above). Then I
created my "dirty" working tree:

git fork pavel /data/l/linux-git

and created "nice" tree, good for pulling

git fork good /data/l/linux-good

. I do my work in linux-git. If someone sends me nice patch I should
pass up, I apply it to linux-good with nice message and do

git merge good

in my working tree.


Publishing your trees
~~~~~~~~~~~~~~~~~~~~~

on remote server: (as an optimization...)

cd ~/WWW/git
rsync -zavP rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git .
mv linux-2.6.git good.git

then on localhost: 

cd /data/l/linux-good
rsync -zavP -essh --delete .git pavel@atrey.karlin.mff.cuni.cz:~/WWW/git/good.git

[Oops, bad. cogito -created forks use symlinks in a way which is quite "interesting".]



-- 
Boycott Kodak -- for their patent abuse against Java.
