Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbTJ2CbH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 21:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTJ2CbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 21:31:07 -0500
Received: from services.erkkila.org ([24.97.94.217]:27529 "EHLO erkkila.org")
	by vger.kernel.org with ESMTP id S261850AbTJ2CbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 21:31:01 -0500
Message-ID: <3F9FA513.6090907@erkkila.org>
Date: Wed, 29 Oct 2003 11:31:31 +0000
From: Paul Erkkila <pee@erkkila.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031027
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_services-32552-1067394660-0001-2"
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: [Patch] gre tunnels in 2.5/6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_services-32552-1067394660-0001-2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


This small patch fixes gre tunnels using keys (and probably 
sequencing/checksums) in 2.{5,6}.
If params aren't set before ipgre_tunnel_init is called, it 
miscalculates the header size, and
stomps on itself when encapsulating packets.

I'm not sure if the later initialization can be removed, or if this is 
the *correct* patch. It does
allow tunnels to work here.

-pee

(this might be a double send, i sent it last sunday, but didn't see it 
show up in the lists)

--=_services-32552-1067394660-0001-2
Content-Type: text/plain; name="gre.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gre.patch"

--- net/ipv4/ip_gre.c.orig	2003-10-26 19:44:26.000000000 +0000
+++ net/ipv4/ip_gre.c	2003-10-26 19:55:33.000000000 +0000
@@ -276,6 +276,8 @@
 	  return NULL;
 
 	dev->init = ipgre_tunnel_init;
+	nt = dev->priv;
+	nt->parms = *parms;
 
 	if (register_netdevice(dev) < 0) {
 		kfree(dev);

--=_services-32552-1067394660-0001-2--
