Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318034AbSFSWM7>; Wed, 19 Jun 2002 18:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318035AbSFSWM6>; Wed, 19 Jun 2002 18:12:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10416 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318034AbSFSWM6>;
	Wed, 19 Jun 2002 18:12:58 -0400
Date: Wed, 19 Jun 2002 15:06:06 -0700 (PDT)
Message-Id: <20020619.150606.127425775.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: torvalds@transmeta.com, aebr@win.tue.nl, phillips@bonn-fries.net,
       Andries.Brouwer@cwi.nl, viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH+discussion] symlink recursion
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15632.55289.204683.26908@napali.hpl.hp.com>
References: <20020619181814.GA16548@win.tue.nl>
	<Pine.LNX.4.44.0206191136200.2889-100000@home.transmeta.com>
	<15632.55289.204683.26908@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Wed, 19 Jun 2002 12:14:01 -0700
   
   on ia-64, I see the following (2.4.18, with gcc3.1):
   
   	- ext2_follow_link():	 16 bytes/frame
   	- vfs_follow_link():	 56 bytes/frame
   	- link_path_walk():	128 bytes/frame
   	---------------------	---------------
   	total:			200 bytes/frame
   
   Just about in line with what you'd expect given that registers are
   64 bits.

On sparc64 the situation is much worse (due to register windows)
which means any non-leaf function (function which invokes no nother
functions) equals 192 bytes of stack space per frame minimum.

