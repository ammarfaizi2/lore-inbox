Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265835AbUBKVKL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 16:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266099AbUBKVKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 16:10:11 -0500
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:25571 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S265835AbUBKVKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 16:10:06 -0500
Date: Wed, 11 Feb 2004 13:09:30 -0800
From: Tim Hockin <thockin@sun.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: PATCH - raise max_anon limit
Message-ID: <20040211210930.GJ9155@sun.com>
Reply-To: thockin@sun.com
References: <20040206221545.GD9155@sun.com> <20040207005505.784307b8.akpm@osdl.org> <20040207094846.GZ21151@parcelfarce.linux.theplanet.co.uk> <20040211203306.GI9155@sun.com> <Pine.LNX.4.58.0402111236460.2128@home.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6CXocAQn8Xbegyxo"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402111236460.2128@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6CXocAQn8Xbegyxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 11, 2004 at 12:38:11PM -0800, Linus Torvalds wrote:
> > Maybe that is just the simplest answer?  It can be a simple constant that is
> > changeable at compile time, and leave it at that
> > 
> > What's most likely to cause the least argument?
> 
> I'd suggest just raising it to 64k or so, that's likely to be acceptable, 
> and it's a static 8kB array. That's likely not much more than the code 
> needed to worry about dynamic entries, yet I'd assume that changing it 
> from 256 to 64k is going to make most people say "enough".

How's this then?  It doesn't get any simpler..

-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's

--6CXocAQn8Xbegyxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="max_anon_raise-2.6.2-1.diff"

===== fs/super.c 1.110 vs edited =====
--- 1.110/fs/super.c	Sun Oct  5 01:07:55 2003
+++ edited/fs/super.c	Wed Feb 11 11:56:02 2004
@@ -535,7 +535,8 @@
  * filesystems which don't use real block-devices.  -- jrs
  */
 
-enum {Max_anon = 256};
+/* you can raise this as high as 2^MINORBITS if you REALLY need more */
+enum {Max_anon = 65536};
 static unsigned long unnamed_dev_in_use[Max_anon/(8*sizeof(unsigned long))];
 static spinlock_t unnamed_dev_lock = SPIN_LOCK_UNLOCKED;/* protects the above */
 

--6CXocAQn8Xbegyxo--
