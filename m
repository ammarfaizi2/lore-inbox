Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbVCJXQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbVCJXQf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 18:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbVCJXM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 18:12:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:12251 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262117AbVCJXLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 18:11:23 -0500
Date: Thu, 10 Mar 2005 15:08:43 -0800
From: Greg KH <greg@kroah.com>
To: davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       jmorris@redhat.com, yoshfuji@linux-ipv6.org, kaber@coreworks.de,
       netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: [06/11] [TCP]: Put back tcp_timer_bug_msg[] symbol export.
Message-ID: <20050310230843.GG22112@kroah.com>
References: <20050310230519.GA22112@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310230519.GA22112@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------



This wrecks the ipv6 modular build for a lot of people.
In fact, since I always build ipv6 modular I am surprised
I never hit this.  My best guess is that my compiler is
optimizing the reference away, but that can never be
depended upon and the symbol export really is needed.

[TCP]: Put back tcp_timer_bug_msg[] symbol export.
  
It is needed for tcp_reset_xmit_timer(), which is invoked by
tcp_prequeue() which is invoked from tcp_ipv6.c
 
Signed-off-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -Nru a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
--- a/net/ipv4/tcp_timer.c	2005-03-09 17:20:38 -08:00
+++ b/net/ipv4/tcp_timer.c	2005-03-09 17:20:38 -08:00
@@ -38,6 +38,7 @@
 
 #ifdef TCP_DEBUG
 const char tcp_timer_bug_msg[] = KERN_DEBUG "tcpbug: unknown timer value\n";
+EXPORT_SYMBOL(tcp_timer_bug_msg);
 #endif
 
 /*


