Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbTJML6t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 07:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbTJML6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 07:58:49 -0400
Received: from gaia.cela.pl ([213.134.162.11]:6671 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S261723AbTJML6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 07:58:48 -0400
Date: Mon, 13 Oct 2003 13:58:16 +0200 (CEST)
From: Maciej Zenczykowski <maze@cela.pl>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
cc: John Bradford <john@grabjohn.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Why are bad disk sectors numbered strangely, and what happens
 to them?
In-Reply-To: <33d201c3917d$668c8310$5cee4ca5@DIAMONDLX60>
Message-ID: <Pine.LNX.4.44.0310131344270.14165-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm.  That could well be an answer.  I'll think about it.
> 
> Actually I should just write over the whole partition for the present time.
> When the drive's self-test detected that one bad sector, I could figure out
> which partition it was in (though not which file, which is why I asked one
> of those questions several times already).  The drive's self-test read the
> entire drive and the other partitions had no detectable errors.

Instead of zeroing the entire partition just zero that single sector.
something like:

dd if=/dev/zero of=/dev/hda bs=512 seek=$lbasector conv=notrunc count=1

possibly first check (by reading in the oposite direction:
dd if=/dev/hda of=/dev/null bs=512 skip=$lbasector count=1)
if this is indeed the place were you get the read error (in syslog)...
if you can read anything from it then read it to a file and write it back 
from the file...

as for checking which file contains it... hmm file->sector->lba mapping 
can be performed... I don't know about the other direction.  Worst case 
would require checking the mapping of all files on the partition (and 
assuming it's not in an empty area or non-file system area).

Cheers,
MaZe.

