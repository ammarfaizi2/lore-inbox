Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbTDOIGk (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 04:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264397AbTDOIGk (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 04:06:40 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:977 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S264394AbTDOIGi (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 04:06:38 -0400
Date: Tue, 15 Apr 2003 10:18:19 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] qdisc oops fix
Message-ID: <20030415081819.GD15944@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, Alan,

The following patch (recently posted by Martin Volf <mv@inv.cz>) indeed
fixes the described (Message-Id: <20030412102137.38b4d3d9.mv@inv.cz>)
instability issue.

Please apply,
-- 
Tomas Szepe <szepe@pinerecords.com>


--- sch_generic.c.orig  2003-01-04 14:42:02.000000000 +0100
+++ sch_generic.c       2003-04-12 08:58:34.000000000 +0200
@@ -372,7 +372,7 @@
        struct Qdisc *sch;
        int size = sizeof(*sch) + ops->priv_size;
 
-       sch = kmalloc(size, GFP_KERNEL);
+       sch = kmalloc(size, GFP_ATOMIC);
        if (!sch)
                return NULL;
        memset(sch, 0, size);
