Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbWHDFnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbWHDFnf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWHDFnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:43:25 -0400
Received: from cantor2.suse.de ([195.135.220.15]:36527 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030315AbWHDFnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:43:21 -0400
Date: Thu, 3 Aug 2006 22:38:38 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "David S. Miller" <davem@davemloft.net>,
       Patrick McHardy <kaber@trash.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 03/23] : H.323 helper: fix possible NULL-ptr dereference
Message-ID: <20060804053838.GD769@kroah.com>
References: <20060804053258.391158155@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="h.323-helper-fix-possible-null-ptr-dereference.patch"
In-Reply-To: <20060804053807.GA769@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Patrick McHardy <kaber@trash.net>

[NETFILTER]: H.323 helper: fix possible NULL-ptr dereference

An RCF message containing a timeout results in a NULL-ptr dereference if
no RRQ has been seen before.

Noticed by the "SATURN tool", reported by Thomas Dillig <tdillig@stanford.edu>
and Isil Dillig <isil@stanford.edu>.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/ipv4/netfilter/ip_conntrack_helper_h323.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.7.orig/net/ipv4/netfilter/ip_conntrack_helper_h323.c
+++ linux-2.6.17.7/net/ipv4/netfilter/ip_conntrack_helper_h323.c
@@ -1092,7 +1092,7 @@ static struct ip_conntrack_expect *find_
 	tuple.dst.protonum = IPPROTO_TCP;
 
 	exp = __ip_conntrack_expect_find(&tuple);
-	if (exp->master == ct)
+	if (exp && exp->master == ct)
 		return exp;
 	return NULL;
 }

--
