Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSIDXgL>; Wed, 4 Sep 2002 19:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316499AbSIDXgL>; Wed, 4 Sep 2002 19:36:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31202 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316491AbSIDXgK>;
	Wed, 4 Sep 2002 19:36:10 -0400
Date: Wed, 04 Sep 2002 16:33:27 -0700 (PDT)
Message-Id: <20020904.163327.118298979.davem@redhat.com>
To: shaggy@austin.ibm.com
Cc: szepe@pinerecords.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org, aurora-sparc-devel@linuxpower.org,
       reiserfs-dev@namesys.com, linuxjfs@us.ibm.com
Subject: Re: [PATCH] sparc32: wrong type of nlink_t
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200209042018.g84KI6612079@shaggy.austin.ibm.com>
References: <20020901094416.GF32122@louise.pinerecords.com>
	<200209042018.g84KI6612079@shaggy.austin.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dave Kleikamp <shaggy@austin.ibm.com>
   Date: Wed, 4 Sep 2002 15:18:05 -0500 (CDT)
   
   I don't like this fix.  I know 32767 is a lot of links, but I don't like
   artificially lowering a limit like this just because one architecture
   defines nlink_t incorrectly.  I'd rather get rid of the compiler warnings
   with a cast in the few places the limit is checked, even though that is
   a little bit ugly.

"incorrectly"?  There are no correct or incorrect values for any
of these types, which is why they are defined on a per-platform
basis.

If you impose different limits on different platforms, that means
that a jfs/reiserfs filesystem that works properly on one platform
may not function properly on another.

That is something I'd certainly deem "incorrect" :-)

Every other filesystem can be plugged into an arbitrary Linux platform
and be expected to work properly, don't make jfs/reiserfs an exception
to this.
