Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVEXKMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVEXKMt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 06:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVEXJjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:39:43 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:52168 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S262018AbVEXJVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:21:35 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524092132.E9377FA7D@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:21:32 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id 1474CFA32

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 09:47:51 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261361AbVEXGin (ORCPT <rfc822;chiakotay@nexlab.it>);

	Tue, 24 May 2005 02:38:43 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVEXGim

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Tue, 24 May 2005 02:38:42 -0400

Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:36873 "EHLO

	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP

	id S261321AbVEXGiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);

	Tue, 24 May 2005 02:38:10 -0400

Received: from miko by dorka.pomaz.szeredi.hu with local (Exim 3.36 #1 (Debian))

	id 1DaSCb-0003Tw-00; Tue, 24 May 2005 07:43:41 +0200

To: mikew@google.com
Cc: jamie@shareable.org, linuxram@us.ibm.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <429277CA.9050300@google.com> (message from Mike Waychison on

	Mon, 23 May 2005 17:39:38 -0700)

Subject: Re: [RFC][PATCH] rbind across namespaces

References: <1116627099.4397.43.camel@localhost> <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu> <1116660380.4397.66.camel@localhost> <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu> <20050521134615.GB4274@mail.shareable.org> <E1DZlVn-0007a6-00@dorka.pomaz.szeredi.hu> <429277CA.9050300@google.com>

Message-Id: <E1DaSCb-0003Tw-00@dorka.pomaz.szeredi.hu>

From: Miklos Szeredi <miklos@szeredi.hu>
Date:	Tue, 24 May 2005 07:43:41 +0200

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org



> FWIW, all this stuff has already been done and posted here.
> 
> Detachable chunks of vfsmounts:
> http://marc.theaimsgroup.com/?l=linux-fsdevel&m=109872862003192&w=2
> 
> 'Soft' reference counts for manipulating vfsmounts without pinning them 
> down:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109872797030644&w=2

I think this might just interest Jamie Lokier.  He had a very similar
poposal recently, but without reference to this patch, so I guess he
wasn't aware of it.

> Referencing vfsmounts in userspace using a file descriptor:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109871948812782&w=2

Why not just use /proc/PID/fd/FD?

> walking mountpoints in userspace: 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109875012510262&w=2

Is this needed?  Userspace can find out mountpoints from /proc/mounts
(or something similar for detached trees).

> attaching mountpoints in userspace:
> http://marc.theaimsgroup.com/?l=linux-fsdevel&m=109875063100111&w=2

Again, bind from/to /proc/PID/fd/FD should work without any new
interfaces.

> detaching mountpoints in userspace:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109880051800963&w=2

What's wrong with sys_umount()?

> getting info from a vfsmount:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109875135030473&w=2

/proc or /sys should do fine for this purpose I think.

I agree, that having "floating trees" could be useful, but I don't see
the point of adding new interfaces to support it.

Miklos
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

