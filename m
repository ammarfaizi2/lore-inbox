Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261294AbTC0TI5>; Thu, 27 Mar 2003 14:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261296AbTC0TI5>; Thu, 27 Mar 2003 14:08:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2054 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261294AbTC0TIz>; Thu, 27 Mar 2003 14:08:55 -0500
Date: Thu, 27 Mar 2003 11:18:59 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre6
In-Reply-To: <20030327084846.C29788@infradead.org>
Message-ID: <Pine.LNX.4.44.0303271113260.31459-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Mar 2003, Christoph Hellwig wrote:
> 
> *grrr* once again this is not tagged in BK.  Could you _please_ ask Linus
> for his nice update release, tag and publish script?

Hey, I'm a retard. I don't actually do the tagging with a script, since I 
usually want to create the tree privately first, and run a final compile 
cycle on it. So I tag it by hand, and then I have a script that outputs 
a list of commands that I just cut-and-paste directly. It's ugly, but it 
works (and it means that running the script doesn't _do_ anything: I have 
to actually take one last look at what I'm going to do before I start it 
all up).

The "release script" is this piece of crap:

	#!/bin/sh
	echo "bk export -w ../linux-$2"
	echo "bk export -h -tpatch -rv$1.. > ../patch-$2"
	echo "export PATH=\$PATH:/home/torvalds/BK/tools"
	echo "changelog v$1 v$2 > ../ChangeLog-$2"
	echo "shortlog --width=72 < ../ChangeLog-$2 > ../ChangeLog"
	echo "cd .."
	echo "tar cf linux-$2.tar linux-$2"
	echo "gzip -9 patch-$2"
	echo "gzip -9 linux-$2.tar"
	echo "touch LATEST-IS-$2"

and that's it. I'd just do "../release-script 2.5.66 2.5.67" from my
kernel directory when I want to generate a 2.5.67 release.

Ok, I'm embarrassed to even admit to doing this. Don't rub it in. It's 
useful to me because sometimes I don't do a full release - I just want to 
pre-generate a change-log of the diff, for example, to judge whether I 
forgot about something.

			Linus "retard" Torvalds

