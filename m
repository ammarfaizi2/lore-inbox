Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261597AbSIXHTp>; Tue, 24 Sep 2002 03:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261598AbSIXHTp>; Tue, 24 Sep 2002 03:19:45 -0400
Received: from unthought.net ([212.97.129.24]:51178 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S261597AbSIXHTn>;
	Tue, 24 Sep 2002 03:19:43 -0400
Date: Tue, 24 Sep 2002 09:24:55 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: linux-kernel@vger.kernel.org
Cc: Hans Reiser <reiser@namesys.com>
Subject: ReiserFS buglet
Message-ID: <20020924072455.GE2442@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org, Hans Reiser <reiser@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First:

In linux-2.4.19, I found the following:

fs/reiserfs/super.c:707

 s->s_blocksize = sb_blocksize(rs);
 s->s_blocksize_bits = 0;
 while ((1 << s->s_blocksize_bits) != s->s_blocksize)
     s->s_blocksize_bits ++;


What happens if there's a bit-flip on the disk so that s->s_blocksize is
not a power of two ?

I would suggest replacing the '!=' with a '<' in the while loop and
adding a sanity check afterwards.

After all, a single bit-flip in the root fs superblock would cause the
system to hang silently (but spinning really fast!) at boot.


Second:

As I see it, the ReiserFS journal has the same problems as jbd wrt. to
atomicity of write operations of indexes.  Please see my recent mail
about the jbd problems.


-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
