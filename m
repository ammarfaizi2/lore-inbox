Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbVJJLrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVJJLrf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 07:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVJJLrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 07:47:35 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:58053 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750754AbVJJLre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 07:47:34 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: spereira <pereira.shaun@gmail.com>
Subject: Re: 32 bit (socket layer) ioctl emulation for 64 bit kernels- Question regarding...
Date: Mon, 10 Oct 2005 13:48:48 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <3ad486780510092121h78a522cat11f33581dfc670dc@mail.gmail.com>
In-Reply-To: <3ad486780510092121h78a522cat11f33581dfc670dc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510101348.49598.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maandag 10 Oktober 2005 06:21, spereira wrote:
>
> Is there currently an alternative to register_ioctl32_conversion that
> would help achive 32 bit ioctl emulation at the socket layer?
> Any suggestions/advice whould be much appreciated.

The correct solution would be to add the missing functionality to
net/socket.c and move over the implementation of SIOC* from
fs/compat_ioctl.c. Getting the code path right is a little tricky,
but I think a patch to fix this up would be appreciated.

As a start, you could define a compat_sock_ioctl along the
lines of compat_blkdev_ioctl and add your own handlers to the
x25_proto_ops, but IMHO it would makes sense to get rid of stuff
like dev_ifsioc from fs/compat_ioctl.c at the same time by
introducing a new compat_dev_ioctl called from compat_sock_ioctl.

	Arnd <><
