Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262513AbULOWMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbULOWMN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 17:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbULOWMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 17:12:12 -0500
Received: from moutng.kundenserver.de ([212.227.126.191]:52473 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262513AbULOWME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 17:12:04 -0500
To: =?iso-8859-1?Q? "Michael_S=2E_Tsirkin" ?= <mst@mellanox.co.il>
Subject: =?iso-8859-1?Q?Re:_unregister_ioctl32_conversion_and_modules=2E_ioctl32_revisited=2E?=
From: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>
Cc: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>,
       =?iso-8859-1?Q?Andi_Kleen?= <ak@suse.de>,
       <linux-kernel@vger.kernel.org>, <pavel@suse.cz>, <discuss@x86-64.org>,
       <gordon.jin@intel.com>
Message-Id: <26879984$110314853541c0b5f7483052.49808635@config13.schlund.de>
X-Binford: 6100 (more power)
X-Originating-From: 26879984
X-Mailer: Webmail
X-Routing: DE
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Date: Wed, 15 Dec 2004 23:10:02 +0100
X-Provags-ID: kundenserver.de abuse@kundenserver.de ident:@172.23.4.140
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Michael S. Tsirkin" <mst@mellanox.co.il> schrieb am 15.12.2004,
19:21:09:

> But what if you really wanted to return -ENOIOCTLCMD?

It's not possible to return -ENOIOCTLCMD to user space, because it
is a kernel internal value that was defined specifically the
purpose of nesting ioctl handlers.

> And, the idea was to get rid of the hash eventually?

Oh, was it? I thought the idea was to get rid of 
register_ioctl32_conversion(). The use of the hash table may be
not as efficient as possible, but it is not actually broken.
The advantage of a global lookup mechanism is that many drivers
don't even need to know about it.

Even if we decide to remove the hash at some later point (after the
dynamic registration is gone), we definitely need a way to get back
to the hashed functions from drivers in the meantime.

       Arnd <><
