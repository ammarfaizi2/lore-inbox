Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319031AbSHFJhR>; Tue, 6 Aug 2002 05:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319032AbSHFJhR>; Tue, 6 Aug 2002 05:37:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:38091 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319031AbSHFJhQ>;
	Tue, 6 Aug 2002 05:37:16 -0400
Date: Tue, 06 Aug 2002 02:28:13 -0700 (PDT)
Message-Id: <20020806.022813.27560736.davem@redhat.com>
To: manfred@colorfullife.com
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] Warn users about machines with non-working WP bit
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D4F942D.7020100@colorfullife.com>
References: <3D4F942D.7020100@colorfullife.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Manfred Spraul <manfred@colorfullife.com>
   Date: Tue, 06 Aug 2002 11:17:33 +0200

   > -		printk("No.\n");
   > +		printk("No (that's security hole).\n");
   >  #ifdef CONFIG_X86_WP_WORKS_OK
   
   Could you explain the hole?
   WP works for user space apps, only ring0 (or ring 0-2?) code
   ignores the WP bit on i386.

So copy_to_user() could write to user areas that are write-proteced.

verify_area() checks aren't enough, consider a threaded application
calling mprotect() while the copy is in progress.
