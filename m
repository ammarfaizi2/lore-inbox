Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317980AbSFSTOc>; Wed, 19 Jun 2002 15:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317981AbSFSTOb>; Wed, 19 Jun 2002 15:14:31 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:17628 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317980AbSFSTO3>;
	Wed, 19 Jun 2002 15:14:29 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15632.55289.204683.26908@napali.hpl.hp.com>
Date: Wed, 19 Jun 2002 12:14:01 -0700
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       Daniel Phillips <phillips@bonn-fries.net>, <Andries.Brouwer@cwi.nl>,
       Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH+discussion] symlink recursion
In-Reply-To: <Pine.LNX.4.44.0206191136200.2889-100000@home.transmeta.com>
References: <20020619181814.GA16548@win.tue.nl>
	<Pine.LNX.4.44.0206191136200.2889-100000@home.transmeta.com>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 19 Jun 2002 11:55:23 -0700 (PDT), Linus Torvalds <torvalds@transmeta.com> said:

  Linus> Yes. But did you look at the stack frames of those things?
  Linus> It's something like 16 bytes for ext2_follow_link (it just
  Linus> calls directly back to the VFS layer), 20 bytes for
  Linus> vfs_follow_link(), and 56 for link_path_walk.

  Linux> ...

  Linus> But there are other numbers, like performance (sometimes
  Linus> linearizing recursion loses, sometimes it wins), or somebody
  Linus> doing the math on ia-64 and showing that the 100 bytes/level
  Linus> on x86 is actually more like 2kB on ia-64 and totally
  Linus> unacceptable.

Just to avoid starting false rumours: on ia-64, I see the following
(2.4.18, with gcc3.1):

	- ext2_follow_link():	 16 bytes/frame
	- vfs_follow_link():	 56 bytes/frame
	- link_path_walk():	128 bytes/frame
	---------------------	---------------
	total:			200 bytes/frame

Just about in line with what you'd expect given that registers are 64 bits.

	--david
