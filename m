Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265947AbUGEEuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265947AbUGEEuD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 00:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265950AbUGEEuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 00:50:03 -0400
Received: from smtp06.web.de ([217.72.192.224]:48044 "EHLO smtp06.web.de")
	by vger.kernel.org with ESMTP id S265947AbUGEEuA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 00:50:00 -0400
Subject: Re: [BUG] FAT broken in 2.6.7-bk15
From: Ali Akcaagac <aliakc@web.de>
To: linux-kernel@vger.kernel.org, stockall@magma.ca,
       hirofumi@mail.parknet.co.jp
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 05 Jul 2004 06:50:07 +0200
Message-Id: <1089003007.601.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yeah here the .config snipplet. But I still wonder how this
> > influences mounting an msdos or vfat partition. Unfortunately I am
> > no expert in FAT related stuff but I assume that textual stuff
> > stored in a filesystem shouldn't affect mounting and unmounting. The
> > only thing NLS changes in a filesystem is special charakters for
> > filenames but it doesn't change the technical structure of the FS
> > itself so in worst case I only get some strange characters shown in
> > filenames.

> Do you have both nls_cp437 and nls_iso8859_1 modules loaded?

Good point. After doing a normal lsmod I only saw that "msdos" and "vfat" modules got loaded and no further language specific stuff. I then tried modprobing 'nls_cp850' and 'nls_iso8859_15' which got loaded fine but same issues. After reconfiguring the Kernel and >>>manually<<< adjusting the msdos part from 437 to 850 and iso8859-1 to iso8859-15 and reloading the msdos module everything worked as expected again. Although I do questionize whether the current changes are so optimal for the user. In the past and that's how I understood OGAWA Hirofumi the msdos driver got it's information from the big NLS submenu of the Kernel configuration and now it has been split out due to some people reporting problems when having select utf8. But having >>>manually<<< to adjust msdos to point to nls modules other than 437 and iso8859-1 is quite cumbersome and leads to misunderstanding. I did saw the changes to msdos when going through my configure process but I assumed that it automaticly handles 437 (as it pointed on default) and I wondered why it has been split out. But I now figured out that it's not loading an OWN module, it's only POINTING to a NLS module >>>by name<<< and that you need to make sure >>>manually<<< to either change it to the module you selected in the NLS submenu or to adjust the NLS submenu by adding the module which msdos refers by default.
It would be pretty nice to have this 'idea' being rethought a bit more so that it doesn't lead into confusion and missunderstandings.


