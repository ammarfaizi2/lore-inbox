Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314487AbSECVQI>; Fri, 3 May 2002 17:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315720AbSECVQI>; Fri, 3 May 2002 17:16:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59371 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314487AbSECVQH>;
	Fri, 3 May 2002 17:16:07 -0400
Date: Fri, 03 May 2002 14:05:07 -0700 (PDT)
Message-Id: <20020503.140507.89264790.davem@redhat.com>
To: bruce.holzrichter@monster.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: my slab cache broken on sparc64
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <61DB42B180EAB34E9D28346C11535A781780F2@nocmail101.ma.tmpw.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
   Date: Fri, 3 May 2002 14:18:55 -0500 

   I am trying to troubleshoot why in 2.5.13, (Though I also saw this in 2.5.7)
   on my UltraSparc, why my slabcache is broken.  Has anyone else seen this?
   
The technique used by the slabcache to verify to pointer
is %100 non-portable and totally wrong.

get_user() MUST be used only on "user pointers", it is being
used on a kernel pointer here.

It would work if the access was surrounded by:

	old_fs = get_fs();
	set_fs(KERNEL_DS);
	... get_user(kernel_pointer) ...
	set_fs (old_fs);

But it is not.
