Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWGDIBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWGDIBU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWGDIBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:01:20 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40902 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750837AbWGDIBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 04:01:19 -0400
Subject: Re: ext4 features (checksums)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Neil Brown <neilb@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <17577.43190.724583.146845@cse.unsw.edu.au>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	 <20060701170729.GB8763@irc.pl>
	 <20060701174716.GC24570@cip.informatik.uni-erlangen.de>
	 <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>
	 <20060703205523.GA17122@irc.pl>
	 <1151960503.3108.55.camel@laptopd505.fenrus.org>
	 <1151964720.16528.22.camel@localhost.localdomain>
	 <17577.43190.724583.146845@cse.unsw.edu.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 04 Jul 2006 09:17:46 +0100
Message-Id: <1152001067.28597.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-07-04 am 09:31 +1000, ysgrifennodd Neil Brown:
> It's been some years that I've felt that most 'logical volume
> management' really belongs in the filesystem.
> Why have a dm that chops devices up in to segments and assembles them to
> look like a big device, only to have that big device chopped up and
> presented as files.  Seems like double handling to me.

Because the interface model is wrong ?

Various people have long said the model actually should look rather more
like

fs to block:
	handle = alloc_extent(near_handle*, info)
	write_extent(handle, buffer, offset, length)
	read_extent(handle, buffer, offset, length)
	free_extent(handle)

(probably with resize_extent)

This makes LVM, remapping, checksumming and the like all naturally slip
out of the fs but not into the block layer.


[Many very good points snipped]
