Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269101AbUINBak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269101AbUINBak (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 21:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269099AbUINBak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 21:30:40 -0400
Received: from mail.kamp-dsl.de ([195.62.99.42]:51934 "HELO dsl-mail.kamp.net")
	by vger.kernel.org with SMTP id S269101AbUINBaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 21:30:39 -0400
Message-ID: <414649B5.4000701@ti.uni-trier.de>
Date: Tue, 14 Sep 2004 03:30:29 +0200
From: Jochen Bern <bern@ti.uni-trier.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: de, en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: procfs and chroot() ... ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to chroot() a server that needs to read one readonly pseudo 
file from /proc . I tried to pinpoint my options to do so ...

-- The alternative to accessing this one pseudo file would be to grant
    the server access to /dev/kmem ... NOT ... ANY ... BETTER!! 8-}
-- Mounting two procfs instances (one normal, one inside the chroot())
    and setting restrictive permissions on the latter makes identical
    changes to the former. (I assume that'ld be the same for ACLs?)
-- Deploying SELinux ... will have to do a good deal of reading to
    even find out what'ld be involved in that ...
-- Mounting a "second" procfs, chroot()ing into the exact subdir the
    file is in, and mounting non-procfs stuff (like the etc dir with the
    configs) *over* the sub-subdirs (ARGH!) would *happen* to rid me of
    all *writable* pseudo files, but still provide read access to way
    more info that I'ld want to provide to the server ...
(- I'll try to Use The Source (tm) so that the server will not close the
    pseudo file, and does the chroot() itself after opening it, but let's
    assume for the sake of the argument that I won't succeed in that.)

Is there an official way (or *should* there be one) to have only *part* 
of a procfs mounted into a chroot() jail?

Kind regards,
								J. Bern
