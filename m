Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261288AbSIWWYc>; Mon, 23 Sep 2002 18:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbSIWWYc>; Mon, 23 Sep 2002 18:24:32 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:47119 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261288AbSIWWYb>; Mon, 23 Sep 2002 18:24:31 -0400
Date: Mon, 23 Sep 2002 23:29:33 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Cc: bobm@fc.hp.com, phil.el@wanadoo.fr, torvalds@transmeta.com
Subject: [PATCH][RFC] oprofile 2.5.38 patch
Message-ID: <20020923222933.GA33523@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At :

http://oprofile.sourceforge.net/oprofile-2.5.html

You can find a very early patch against 2.5.38 (87k) and userspace
tools for the new oprofile stuff. I've split it up into smaller chunks
at http://oprofile.sourceforge.net/oprofile-2.5/ (only for easier
reading).

I would appreciate people's comments. I'm not exactly happy with
buffer_sync.c in particular, so I'd love to find a better way.

The code has been lightly tested on a 2-way PII-400 box, which showed
some quirks, but it seems to work.

Note that you must use the new userspace tools at the URL (and they will
conflict with any existing oprofile stuff, so please don't mix the two).

A short summary of how it works (mostly thought out by Linus ;) :

Each cpu has a linear buffer for capturing EIP/event values. Events such
as munmaps trigger a buffer sync, where the EIP values are converted
into cookie/offset pairs and stored in the global buffer. The cookies
are accessible by the userspace daemon which uses the binary path to
create the sample files. Context switches also need to go in the cpu
buffer. release_task() needs similar tracking in order to prevent
task_struct * accesses after it has been freed.

regards
john
