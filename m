Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271036AbTG1UtQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271038AbTG1Usu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:48:50 -0400
Received: from [198.149.18.6] ([198.149.18.6]:15342 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S271036AbTG1UsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:48:02 -0400
Subject: Re: bug in 2.6.0test2
From: Steve Lord <lord@sgi.com>
To: Nico Schottelius <nico-kernel@schottelius.org>, scholz@wdt.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030728115902.GA18993@schottelius.org>
References: <20030728115902.GA18993@schottelius.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059425249.6601.10.camel@jen.americas.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 28 Jul 2003 15:47:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-28 at 06:59, Nico Schottelius wrote:
> Hello again!
> 
> When trying to boot from a cryptoloop we get the attached error.
> Details:
>    modules loop,cryptoloop,aes (in this order) are loaded with insmod
>    (from initrd)
>    then mounting proc
> 
> Any suggestions / solutions ?
> 
> Nico
> 
> ps: please cc me and scholz AT wdt.de

Something else went wrong before you crashed:

bio too big device loop0 (2 > 0)

This means you cannot use any bio larger than zero to this device,
which is probably why ext2 said this, since it caught the error when
building the bio.

EXT2-fs: unable to read superblock

XFS didn't catch the error building the bio and submitted it, at
which point the I/O tripped the BUG. I can fix this part, but
the original problem is something I know nothing about.

Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
