Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbTFDAm6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 20:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbTFDAm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 20:42:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8597 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262221AbTFDAm5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 20:42:57 -0400
Date: Wed, 4 Jun 2003 01:56:25 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 add_disk(disk) re-registering disk->queue->elevator.kobj (bug?!)
Message-ID: <20030604005625.GF6754@parcelfarce.linux.theplanet.co.uk>
References: <3EDCEA14.2000407@aros.net> <20030603120717.66012855.akpm@digeo.com> <3EDD3D5F.3010509@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EDD3D5F.3010509@aros.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 06:29:19PM -0600, Lou Langholtz wrote:
> Andrew Morton wrote:
> >The ramdisk driver was recently changed to do exactly this.  From what
> >you say it appears that nbd needs the same treatment.

This is utterly ridiculous.  I realize that sysfs is fashionable, but
it should reflect the existing logics, not the other way round.

Guys, there are very valid reasons to have a queue shared by several
disks.  E.g. it can very well act as a serialization mechanism - and
as the matter of fact does in quite a few drivers.

What the fuck is going on?  It's what, the fifth case when we have
somebody export something in sysfs, ignore the lifetime rules for
objects and go "reality doesn't match my theory, too bad for reality"?

Linus, could we *please* put a moratorium on use of sysfs unless the
persons using it had proven that they understand how the objects they
export are used in the tree?  Enough is enough - we already have netdev
drivers to deal with and have to do that *now* thanks to blind sysfs
export.  Now we get random bdev stuff on top of that?  Absofuckinglutely
marvelous.
