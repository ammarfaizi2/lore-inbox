Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261656AbSIXMif>; Tue, 24 Sep 2002 08:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261658AbSIXMif>; Tue, 24 Sep 2002 08:38:35 -0400
Received: from ns.suse.de ([213.95.15.193]:61188 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261656AbSIXMie>;
	Tue, 24 Sep 2002 08:38:34 -0400
To: John Levon <movement@marcelothewonderpenguin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] oprofile 2.5.38 patch
References: <20020923222933.GA33523@compsoc.man.ac.uk.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 24 Sep 2002 14:43:47 +0200
In-Reply-To: John Levon's message of "24 Sep 2002 00:31:55 +0200"
Message-ID: <p73r8fjsgl8.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon <movement@marcelothewonderpenguin.com> writes:

> At :
> 
> http://oprofile.sourceforge.net/oprofile-2.5.html

+       page = (unsigned char *)__get_free_page(GFP_KERNEL);
+       if (!page)
+               return -ENOMEM;
+
+       spin_lock(&oprofilefs_lock);
+       len = sprintf(page, "%lu\n", *value);
+       spin_unlock(&oprofilefs_lock);

wouldn't an on stack buffer do nicely to format a single number ? 

ulong_write_file: 

it doesn't length limit count before passing to kmalloc - hole.
Also has overflow bugs (consider someone passing 0xffffffff-1). 

The sys_lookup_dcookie call looks like a security hole to me. After
all it could allow everybody to lookup random paths by trying all 
dcookies, even though the directories may be unreadable for him. It should 
be probably made root only

Adding a list_head to task_struct looks quite ugly to me. Is there
surely no better way ? e.g. you could just put it in a file private
structure and the daemon keeps the file open.

-Andi
