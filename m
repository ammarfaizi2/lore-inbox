Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVBPSKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVBPSKf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 13:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbVBPSKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 13:10:35 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:47691 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262060AbVBPSKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 13:10:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=JgbBBgiamGnhru5a9gNizhvNUcf2Qs1qpJ5QA8pBP8YSiXUBvnKTrZsZMou34aEtdnf3+mnoMLI/3IH3lHz4jvonFtk+AbQO2abbQUUBT9RyCK3Dep1JsvcVOlL3NH0vN7sbZxwkoKmZwy1byx2h9k45+bSuCG5XEvb85RZ/IUg=
Message-ID: <712fce105021610105eca9ca5@mail.gmail.com>
Date: Wed, 16 Feb 2005 10:10:14 -0800
From: Martin Bogomolni <martinbogo@gmail.com>
Reply-To: Martin Bogomolni <martinbogo@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4 inode/dentry cache not clearing on umount?
In-Reply-To: <712fce105021610034a189430@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <712fce1050216082847bec092@mail.gmail.com>
	 <Pine.LNX.4.61.0502161151370.10018@chaos.analogic.com>
	 <712fce105021609163a605f51@mail.gmail.com>
	 <712fce105021610034a189430@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also .. David :

Are you saying that, on a system with 256Megs of ram, of which the
kernel is reporting only 3-4Mb free because the inode/dentry caches
are taking up most of the memory, and NO page/swap file....

char *p;
p = (char *) malloc( 64*1024*1024 );

I assure you that under these conditions, the malloc( ) will fail with NULL.

---------------------------------

Now, in the meantime I have discovered that merely unmounting the
filesystem is not enough to clear the dcache and icache.

However, if I unmount the filesystem then run:

cat /dev/hda > /dev/null

This causes the inode/dentry cache to finally shrink and the amount of
available free memory increases back to ~200Mb.   However, this
reduction does not immediately take place when the filesystem is
unmounted, and while the filesystem is mounted .. the inode/dentry
cache does not shrink and leaves only 3Mb of available free memory.
