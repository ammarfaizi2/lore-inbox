Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbSJ0LMq>; Sun, 27 Oct 2002 06:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262363AbSJ0LMq>; Sun, 27 Oct 2002 06:12:46 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:54284 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S262360AbSJ0LMp>;
	Sun, 27 Oct 2002 06:12:45 -0500
Date: Sun, 27 Oct 2002 12:18:56 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Andreas Haumer <andreas@xss.co.at>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: rootfs exposure in /proc/mounts
Message-ID: <20021027111856.GA789@alpha.home.local>
References: <Pine.GSO.4.21.0210261458460.29768-100000@steklov.math.psu.edu> <3DBAE931.7000409@domdv.de> <3DBAEC79.5050605@pobox.com> <3DBBBE1B.5050809@xss.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DBBBE1B.5050809@xss.co.at>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I remember this discussion too, and am also used to symlink mtab to
/proc/mounts. But I also remember some people stating that /proc/mounts doesn't
contain all information (some mount flags, nfs options ...) which may be needed
for a mount -o remount, while mtab contains them.

I too agree that it's non-sense to have both mtab and /proc/mounts. If mounts
isn't usable, why keep it ? At the moment, the only reason why I would abandon
this symlink would be that mounts be removed from /proc entirely ! And I also
agree that mtab shouldn't be under /etc (this is the only file that needs to
be written to). At least, it should be moved to /var/state or something like
that, provided it's available early in the boot stage, but this issue is not a
kernel one anyway.

But at this time, I still think that a symlink to /proc/mounts is the safest
solution in embedded or diskless situations, because even if we cannot update
it for the very first mounts, at least it will be correct when /proc is
mounted.

May be we should just accept this case as a common one, and update tools
(mount, umount, df, ?) to be able to use both mtab and /proc/mounts, and simply
ignore any rootfs entry.

Just my 0.02 euros.
Willy

