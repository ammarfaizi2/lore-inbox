Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269803AbUICUCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269803AbUICUCk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 16:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269738AbUICTfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:35:36 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:55514 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S269771AbUICTa6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:30:58 -0400
Date: Fri, 3 Sep 2004 21:30:38 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <518050016.20040903213038@tnonline.net>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Helge Hafting <helge.hafting@hist.no>, Oliver Hunt <oliverhunt@gmail.com>,
       Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Adrian Bunk <bunk@fs.tum.de>, <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
In-Reply-To: <200409031741.i83HfASY017164@laptop11.inf.utfsm.cl>
References: Message from Helge Hafting <helge.hafting@hist.no>    of "Fri, 03
 Sep 2004 10:22:55 +0200." <413829DF.8010305@hist.no>
 <200409031741.i83HfASY017164@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> Helge Hafting <helge.hafting@hist.no> said:

> [...]

>> The only new thing needed is the ability for something to be both
>> file and directory at the same time.

> Then why have files and directories in the first place?

  Good point, we don't need them :) Directories are just a visible
  grouping of files to make it easier for the user to manage. But some
  things aren't really that intuitive with todays layout - especially
  for non-unix users.

  Just an example where the user needs to edit config file for some
  program. Where should he look?
  /etc/app.conf ?
  /etc/app/app.conf ?
  /etc/conf.d/app.conf ?
  /var/lib/app/app.conf ?
  and so on....

  Using file-as-dir isn't really that much of a change. It isn't those
  that will confuse people anyway.

>>                                       Some tools will need
>> a update - usually only because they blindly assume that a directory
>> isn't a file too, or that a file can't be a directory too.  Remove the
>> mistaken assumption and things will work because the underlying system
>> calls (chdir or open) _will_ work.

> But with some weird restrictions: No moving stuff around between files, no
> linking, some "files" can't be deleted (how would you handle removing the
> principal stream of a file?).

  Well. there are read-only files. And if you remove the main stream
  (which is the file, really) then it will all be gone =)

>  Some stuff you'd love to do (is, in fact, the
> reason for this all) just can't be allowed (i.e., J. Random Luser setting
> his own icon for system-wide emacs).

  Users do not normally have write permissions to system-wide
  applications. Why would it be any different now?

>  So the tools/scripts/users/sysadmins
> will have to be painfully aware that some of the files aren't, and some of
> the directories aren't either. Major pain in the neck to use, if you look
> closer.  Add extra kernel complexity. For little (if any) gain.

  Not sure what you mean "aren't". Things shouldn't be that much
  different to administer. Normal permissions should still apply. Sure
  extra complexity comes _if_ you want to use extended features that
  are using meta-info. But there is where we need some patches to tar
  and other backup tools.

  One other way would be to enter a specific mode (chroot, a bash
  flag --show-metas, etc) that would allow all streams and metas to be
  seen as files in directories. Then tar and other tools would back it
  all up. Restoring will be a little trickier as we don't know if
  stuff was files or folders before. But I am sure that would be
  solvable. Perhaps a tool to convert them back to normal files with
  meta-data and streams.

  ~S

