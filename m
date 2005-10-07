Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbVJGX4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbVJGX4i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 19:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbVJGXzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 19:55:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:28630 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964949AbVJGXz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 19:55:27 -0400
Date: Fri, 7 Oct 2005 16:55:08 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, dhowells@redhat.com
Subject: [patch 7/7] key: plug request_key_auth memleak
Message-ID: <20051007235508.GH23111@kroah.com>
References: <20051007234348.631583000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="key-rka-memleak.patch"
In-Reply-To: <20051007235353.GA23111@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Plug request_key_auth memleak.  This can be triggered by unprivileged
users, so is local DoS.

Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 security/keys/request_key_auth.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.13.y.orig/security/keys/request_key_auth.c
+++ linux-2.6.13.y/security/keys/request_key_auth.c
@@ -96,6 +96,7 @@ static void request_key_auth_destroy(str
 	kenter("{%d}", key->serial);
 
 	key_put(rka->target_key);
+	kfree(rka);
 
 } /* end request_key_auth_destroy() */
 

--
