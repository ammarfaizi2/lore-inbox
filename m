Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbULFQdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbULFQdm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 11:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbULFQdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 11:33:42 -0500
Received: from main.gmane.org ([80.91.229.2]:12426 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261549AbULFQdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 11:33:40 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: Re: [BUG] null-pointer deref (perhaps reiserfs3)
Date: Mon, 06 Dec 2004 17:35:11 +0100
Message-ID: <cp21l0$mve$1@sea.gmane.org>
References: <cp02a6$57j$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p5484bc1b.dip.t-dialin.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8a4) Gecko/20040927
X-Accept-Language: de, en
In-Reply-To: <cp02a6$57j$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> on a machine that i can only reach via SSH at the moment, i got a 
> null-pointer dereference (see below). The machine runs kernel 2.6.9 
> without any additional patches.
> 
> It happened, while i was doing a "make install". A command within the 
> "installkernel"-script segfaulted. It seems that only the filesystem 
> mounted to /boot is affected. Any access to that FS blocks.

Here's how to reproduce it:

dd if=/dev/zero of=image bs=1M count=40
mkreiserfs -f image
mount -o loop image /mnt/test
cp -r /etc/ /mnt/test

The kernel will Oops, and cp will segfault.

After that, umount -r /mnt/test will fail or block.
The computer will not reboot or halt.

