Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422814AbWA1CXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422814AbWA1CXb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422806AbWA1CWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:22:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:29370 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422801AbWA1CWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:22:23 -0500
Date: Fri, 27 Jan 2006 18:21:17 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       davem@davemloft.net
Subject: [patch 08/12] [NET]: Make second arg to skb_reserved() signed.
Message-ID: <20060128022117.GI17001@kroah.com>
References: <20060128020629.908825000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="net-make-second-arg-to-skb_reserved-signed.patch"
In-Reply-To: <20060128022023.GA17001@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.15.2 -stable review patch.  If anyone has any objections, please let 
us know.

------------------

From: David S. Miller <davem@davemloft.net>

Some subsystems, such as PPP, can send negative values
here.  It just happened to work correctly on 32-bit with
an unsigned value, but on 64-bit this explodes.

Figured out by Paul Mackerras based upon several PPP crash
reports.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/linux/skbuff.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15.1.orig/include/linux/skbuff.h
+++ linux-2.6.15.1/include/linux/skbuff.h
@@ -927,7 +927,7 @@ static inline int skb_tailroom(const str
  *	Increase the headroom of an empty &sk_buff by reducing the tail
  *	room. This is only allowed for an empty buffer.
  */
-static inline void skb_reserve(struct sk_buff *skb, unsigned int len)
+static inline void skb_reserve(struct sk_buff *skb, int len)
 {
 	skb->data += len;
 	skb->tail += len;

--
