Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261442AbSJMHC3>; Sun, 13 Oct 2002 03:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261447AbSJMHC3>; Sun, 13 Oct 2002 03:02:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:35212 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261442AbSJMHC2>;
	Sun, 13 Oct 2002 03:02:28 -0400
Date: Sun, 13 Oct 2002 00:01:27 -0700 (PDT)
Message-Id: <20021013.000127.43007739.davem@redhat.com>
To: wagnerjd@prodigy.net
Cc: robm@fastmail.fm, hahn@physics.mcmaster.ca, linux-kernel@vger.kernel.org,
       jhoward@fastmail.fm
Subject: Re: Strange load spikes on 2.4.19 kernel
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <000001c27286$6ab6bc60$7443f4d1@joe>
References: <113001c27282$93955eb0$1900a8c0@lifebook>
	<000001c27286$6ab6bc60$7443f4d1@joe>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
   Date: Sun, 13 Oct 2002 02:01:44 -0500

   I'll let you in on a dirty little secret.  The Linux file system does
   not utilize SMP.  That's right.  All file processes go through one and
   only one processor.  It has to do with the fact that the Linux kernel is
   a non-preemptive kernel.

Not true, page cache accesses (translation: read and write)
go through the page cache which is fully multi-threaded.

Allocating blocks and inodes, yes that is currently single
threaded on SMP.  But there is no fundamental reason for that,
we just haven't gotten around to threading that bit yet.
