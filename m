Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265700AbSJSX5u>; Sat, 19 Oct 2002 19:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265701AbSJSX5u>; Sat, 19 Oct 2002 19:57:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56278 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265700AbSJSX5t>;
	Sat, 19 Oct 2002 19:57:49 -0400
Date: Sat, 19 Oct 2002 16:54:51 -0700 (PDT)
Message-Id: <20021019.165451.110952098.davem@redhat.com>
To: acme@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: only produce one record in fib_seq_show
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021019233236.GI14009@conectiva.com.br>
References: <20021019233236.GI14009@conectiva.com.br>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This change is problematic, the FIB etc. lookup engine internal
structure must be entirely private to the implementation.

That allows it to be changed arbitrarily and the rest of the
kernel will not notice.

You should probably move the seq_file handling here directly back into
the routing code.

Really, we should not be exporting all of these lookup tables merely
for the sake of ip_proc.c, in fact move all this seq_file stuff back
into the arp/udp/fib/etc. places they came from.  Exporting these
tables just for this makes no sense the more I think about it.
