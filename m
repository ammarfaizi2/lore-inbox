Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbTBTNSB>; Thu, 20 Feb 2003 08:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265378AbTBTNSB>; Thu, 20 Feb 2003 08:18:01 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:42637 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S265351AbTBTNSA>;
	Thu, 20 Feb 2003 08:18:00 -0500
Subject: cifs leaks memory like crazy in 2.5.61
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Steven French <sfrench@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045747684.6760.32.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 20 Feb 2003 14:28:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

I've been using cifs in 2.5.61 instead of smbfs (it has problems with
slab debugging) for 4.5 days now and I just noticed a bad thing.
I was looking at /proc/slabinfo and this jumped out at me:

size-64           1843081 1847421     72 .....

that's a _lot_ of allocations.
I tried to figure out what was leaking and every time I listed a
directory mounted from a samba server it increased. A simple ls -R was
scary to see.

Then I unmounted all my cifs filesystems (two) and removed the cifs
module and got this:

kmem_cache_destroy: Can't free all objects e8eefd00
cifs_destroy_request_cache: error not all structures were freed

Is this a known problem?

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.
