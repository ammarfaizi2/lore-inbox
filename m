Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbUKFKTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUKFKTI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 05:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbUKFKTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 05:19:06 -0500
Received: from [61.48.52.143] ([61.48.52.143]:5096 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261356AbUKFKTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 05:19:02 -0500
Date: Sat, 6 Nov 2004 01:10:26 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200411060910.iA69AQQ00807@adam.yggdrasil.com>
To: cw@f00f.org
Subject: Re: [PATCH] major devfs shrink based on tmpfs and lookup traps
Cc: helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2004 13:13:49 -0800, Chris Wedgwood wrote:
>wow, that's pretty neat.... but isn't devfs going to be killed off
>sooner or later anyhow?

	I expect most functionality that people refer to as "devfs" to
persist and be more widely adopted, although, with the right choice of
terminology, it may be possible to say that "devfs" has been "killed
off."  I started writing a long explanation of this, but I can see that
that will take hours.  Suffice it to say that I really only need to
argue the following much simpler claim to justify integration of this
devfs implementation:


	Under almost any likely engineering plan for devfs, including
ones that could be described as devfs being "killed off", adopting my
version of devfs now will likely make futue transitions easier both
for users and for kernel developers.


	Why should the new devfs make future transitions easier?
Because, first of all, replacing devfsd with devfs_helper using tmpfs
lookup trapping, makes it much more practical to provide future devfs
changes that might not even be noticed by devfs end users.  The lookup
trap functionality which likely will stay forever (and, by the way, is
functionality under the new system).

	Secondly, the small devfs implementation makes it easier for
kernel developers to make changes.  For example, it would not be much
work to change the current implementation to create text files in
sysfs and have user level software adjust /dev accordingly and devfs
systems that had made the move to devfs_helper probably wouldn't
notice (after installing whatever user level software was needed to
synchronize /sys/blah/devfs with /dev).

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
