Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTJYXUl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 19:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbTJYXUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 19:20:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:65409 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262861AbTJYXUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 19:20:39 -0400
Date: Sat, 25 Oct 2003 16:18:47 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: hirofumi@mail.parknet.co.jp, g.liakhovetski@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NLS as module
Message-Id: <20031025161847.4b13a986.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0310260049030.1490-100000@poirot.grange>
References: <87d6cloaf6.fsf@devron.myhome.or.jp>
	<Pine.LNX.4.44.0310260049030.1490-100000@poirot.grange>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Oct 2003 00:55:18 +0200 (CEST) Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:

| On Sat, 25 Oct 2003, OGAWA Hirofumi wrote:
| 
| > Guennadi Liakhovetski <g.liakhovetski@gmx.de> writes:
| >
| > > Problem: NLS support can only be compiled in the kernel - and not as a
| > > module. And if you don't configure one of Joliet / FAT and some other
| > > filesystems at kernel compile-time, you can't compile these filesystems
| > > later as modules(*). However, I see nothing that would prevent one from
| > > compiling nls_base as a module. I tried - it worked, but I didn't actually
| > > use any of the codepages. Just tried insmod nls_base, insmod <fs>, mount.
| > > So, is it desired / really this trivial or are there some real reasons why
| > > nls_base cannot be properly done as a module? I am attaching a naive
| > > patch - but not really understanding NLS internals and not being able to
| > > extensively test it, it might be not quite correct.
| >
| > Sound good to me. And I like this, but it may be more test needed
| > (i.e. module autoload etc.). So I suggest it start on development
| > tree. And backport after it.
| 
| Sure. Attached is a patch against 2.6.0-test7. Looks like it's not going
| to make it into 2.6.0, but, maybe later. And I reversed the dependencies -
| looks more logical, that FAT, SMB, etc. depend on NLS, and not vise versa.
| I tested it briefly, seems to work.

I would prefer to see the opposite:  selecting an FS that requires NLS
should force NLS to be enabled, via "select NLS".
For example:


| diff -ur linux-2.6.0-test7/fs/Kconfig linux-2.6.0-test7.new/fs/Kconfig
| --- linux-2.6.0-test7/fs/Kconfig	Thu Oct  9 22:11:31 2003
| +++ linux-2.6.0-test7.new/fs/Kconfig	Sat Oct 25 21:24:13 2003
| @@ -246,6 +246,7 @@
| 
|  config JFS_FS
|  	tristate "JFS filesystem support"
| -	depends on NLS
	select NLS
|  	help
|  	  This is a port of IBM's Journaled Filesystem .  More information is
|  	  available in the file Documentation/filesystems/jfs.txt.
| @@ -464,6 +465,8 @@
|  	  local network, you probably do not need an automounter, and can say
|  	  N here.


--
~Randy
