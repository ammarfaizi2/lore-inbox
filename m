Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUGLXDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUGLXDL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 19:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264154AbUGLXDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 19:03:10 -0400
Received: from quechua.inka.de ([193.197.184.2]:65431 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264153AbUGLXDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 19:03:06 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
Organization: Deban GNU/Linux Homesite
In-Reply-To: <40F03665.90108@tlinx.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1Bk9pA-0008HQ-00@calista.eckenfels.6bone.ka-ip.net>
Date: Tue, 13 Jul 2004 01:03:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In article <40F03665.90108@tlinx.org> you wrote:
> My cases have been "vim" edited files.  I'd sorta think once vim has 
> exited, the
> data has been flushed, but that's just a WAG...

just a small background investigation, I checked joe:

   open("test.txt", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
   write(3, "test\ntest\n", 10)            = 10
   close(3)                                = 0

... which does not fsync... (it is also not an option in the source)

and vim:

   rename("test.txt", "test.txz~")         = 0
   open("test.txt", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
   write(3, " test\ntest\n", 11)           = 11
   close(3)                                = 0
   chmod("test.txt", 0100664)              = 0

... does no fsync, eighter.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
