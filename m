Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTFOGF0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 02:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTFOGF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 02:05:26 -0400
Received: from rth.ninka.net ([216.101.162.244]:32384 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261928AbTFOGFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 02:05:23 -0400
Subject: Re: New struct sock_common breaks parisc 64 bit compiles with a
	misalignment
From: "David S. Miller" <davem@redhat.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1055221067.11728.14.camel@mulgrave>
References: <1055221067.11728.14.camel@mulgrave>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055657946.6481.6.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jun 2003 23:19:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-09 at 21:57, James Bottomley wrote:
> The problem seems to be that the new struct sock_common ends with a
> pointer and an atomic_t (which is an int on parisc), so the compiler
> adds an extra four bytes of padding where none previously existed in
> struct tcp_tw_bucket, so the __u64 ptr tricks with tw_daddr fail.

I'm fixing this, but why does it "fail"?  You should get unaligned
traps which get fixed up by the trap handler.

If that isn't happening, lots of things in the networking should
break on you.

-- 
David S. Miller <davem@redhat.com>
