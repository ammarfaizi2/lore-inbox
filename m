Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287212AbSBGKvl>; Thu, 7 Feb 2002 05:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287244AbSBGKvb>; Thu, 7 Feb 2002 05:51:31 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:33545 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S287212AbSBGKvT>; Thu, 7 Feb 2002 05:51:19 -0500
Date: Thu, 7 Feb 2002 11:50:32 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <Pine.LNX.4.33.0202061529280.1714-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0202071141580.5615-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 6 Feb 2002, Linus Torvalds wrote:

> The problem I have with piping patches directly to bk is that I don't like
> to switch back-and-forth between reading email and applying (and fixing
> up) patches. Even if the patch applies cleanly (which most of them tend to
> do) I still usually need to do at least some minimal editing of the commit
> message etc (removing stuff like "Hi Linus" etc).

I don't know how much your scripts already do, so below is just a
suggestion how to do some of the preprocessing of patches already during
email reading (the bk magic has to be added by someone else).

bye, Roman

#! /bin/bash

rm -f /tmp/test-patch /tmp/test-log

IFS=""
log=y
while read -r line; do
case "$line" in
---\ *)
	log=n
	;;
esac
test $log = y && echo "$line" >> /tmp/test-log
echo "$line" >> /tmp/test-patch
done

(
	oldtty=`stty -g`
	reset -Q
	vim -o /tmp/test-log /tmp/test-patch
	echo -n "ok?"
	read
	# do more
	stty $oldtty
) < /dev/tty >& /dev/tty


