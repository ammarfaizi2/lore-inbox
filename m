Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264518AbTLVVnK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 16:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbTLVVnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 16:43:10 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:15287 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S264518AbTLVVnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 16:43:05 -0500
Subject: loop driver, device-mapper and crypto
From: Christophe Saout <christophe@saout.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>,
       Joe Thornber <thornber@sistina.com>
Content-Type: text/plain
Message-Id: <1072129379.5570.73.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Dec 2003 22:42:59 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

again I've read that there are problems with the loop driver in the
kernel with block device backing.

In 2.6 we have a device-mapper which does such things in a much more
generic way. I've already talked to a bunch of people working on loop
and cryptoloop (also with Clemens Fruhwirth, the cryptoloop maintainer)
and they all agreed that device-mapper is probably the most correct way
to go, and would be happier if the loop driver was used for files only.

I've written a device-mapper target "dm-crypt" some month ago which uses
cryptoapi and is compatible with cryptoloop. I never got much feedback,
some people tested it and found it to work just fine while cryptoloop
didn't, back then, when the test-series started or so.

Unfortunately I never got much public support on LKML itself and was
mostly ignored. And I'm not a politician...

Well, I just talked to Joe Thornber (again, he helped me developing the
patch) and he wrote:

> I'm happy to take the dm-crypt stuff into my unstable tree.  I don't
> think you'll get it into the kernel unless you get the cryptoloop
> people to publically (ie. on lkml) support you.

Well, you see, I'm a sort of difficult situation here. I would really be
happy to hear what you think of it, if it's worth to invest more energy
or not.

The target is currently a single file and makes use of dm-daemon.c from
Joe's current device-mapper patchset where the snapshot, mirror and
multpath targets are being developed.

The two patches (dm-daemon and the actual dm-crypt) are following.

A short introduction how to use the target:
http://marc.theaimsgroup.com/?l=linux-kernel&m=105967481007242&w=2

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

