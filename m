Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262539AbVAPQY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbVAPQY6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 11:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVAPQY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 11:24:58 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:49298 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S262540AbVAPQXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 11:23:31 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: User space out of memory approach
To: Edjard Souza Mota <edjard@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ilias Biris <xyz.biris@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Sun, 16 Jan 2005 17:28:26 +0100
References: <fa.lcmt90h.1j1scpn@ifi.uio.no> <fa.ht4gei4.1g5odia@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1CqDGM-0000wi-00@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edjard Souza Mota wrote:

> What do you think about the point we are trying to make, i.e., moving the
> ranking of PIDs to be killed to user space?

If my system needs the OOM killer, it's usurally unresponsive to most
userspace applications. A normal daemon would be swapped out before the
runaway dhcpd grows larger than the web cache. It would have to be a mlocked
RT task started from early userspace. It would be difficult to set up (unless
you upgrade your distro), and almost nobody will feel like tweaking it to
take the benefit (OOM == -ECANNOTHAPPEN).

What about creating a linked list of (stackable) algorhithms which can be
extended by loading modules and resorted using {proc,sys}fs? It will avoid
the extra process, the extra CPU time (and task switches) to frequently
update the list and I think it will decrease the typical amount of used
memory, too.
