Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161195AbVIPRqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161195AbVIPRqP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 13:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161205AbVIPRqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 13:46:15 -0400
Received: from seven.metux.de ([193.16.1.1]:6294 "EHLO metux.de")
	by vger.kernel.org with ESMTP id S1161195AbVIPRqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 13:46:14 -0400
Date: Fri, 16 Sep 2005 19:45:59 +0200
From: Enrico Weigelt <weigelt@metux.de>
To: linux kernel list <linux-kernel@vger.kernel.org>
Subject: reparing / editing filesystem while mounted
Message-ID: <20050916174559.GA247@nibiru.local>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks,


I've sometimes the situation where I'd like to edit or fsck a 
currently mounted filesystem. Of course this really dangerous.

It would be great if there was an API for low-level filesystem 
access, ie. directly changing data blocks, directory entries, 
inodes, etc. The (modified) fs driver sitting behind it can so
take care that we dont have collision with the other fs operations,
ie. proper locking, buffer flushing, etc.
The modified fsck now entirely works with this API.


This API for example could provide:

    + superblock access

    + directory changes w/o inode access
	-> sometimes we've got broken dirents which cannot be 
	   changed/removed by normal fs operation (unlink(),etc)
	   often the user's already happy with clearing them.
	-> if we've got a lost inode, we can connect it to some
	   dir (ie /lost+found) manually this way

    + inode changes
	-> undeleting inodes
	-> fixing wrong refcnts
	-> clearing broken inodes / block tables, etc.

    ...

We probably need some journaling/messaging system so the kernel
can tell the userland fsck when something important changes, ie. 
if we're checking directory connectivity and some dirent changes.


Of course this would all be very fs specific. But its implemented
at least for the most important disk fs'es (ie ext2/3) it would 
be a great help for people running 24/7 online systems.


cu
-- 
---------------------------------------------------------------------
 Enrico Weigelt    ==   metux IT service

  phone:     +49 36207 519931         www:       http://www.metux.de/
  fax:       +49 36207 519932         email:     contact@metux.de
  cellphone: +49 174 7066481
---------------------------------------------------------------------
 -- DSL ab 0 Euro. -- statische IP -- UUCP -- Hosting -- Webshops --
---------------------------------------------------------------------
