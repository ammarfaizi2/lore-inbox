Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUGRDx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUGRDx4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 23:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUGRDx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 23:53:56 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55513 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261451AbUGRDxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 23:53:54 -0400
Date: Sun, 18 Jul 2004 05:53:49 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, greg@kroah.com
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [patch] 2.6.8-rc1-mm1: work around broken USB DocBook generation
Message-ID: <20040718035349.GR14733@fs.tum.de>
References: <20040713182559.7534e46d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040713182559.7534e46d.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 06:25:59PM -0700, Andrew Morton wrote:
>...
> All 252 patches:
>...
> bk-usb.patch
>...

This causes the following error during "make psdocs":

<--  snip  -->

...
  DB2PS   Documentation/DocBook/usb.ps
Using catalogs: /etc/sgml/catalog
Using stylesheet: /usr/share/docbook-utils/docbook-utils.dsl#print
Working on: 
/home/bunk/linux/kernel-2.6/linux-2.6.8-rc1-mm1-full/Documentation/DocBook/usb.sgml
jade:/home/bunk/linux/kernel-2.6/linux-2.6.8-rc1-mm1-full/Documentation/DocBook/usb.sgml:549:16:E: 
end tag for "VARIABLELIST" which is not finished
make[1]: *** [Documentation/DocBook/usb.ps] Error 8

<--  snip  -->


The patch below works around this issue by not letting it look like a 
valid kerneldoc.


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc1-mm1-full/include/linux/usb.h.old	2004-07-18 05:47:38.000000000 +0200
+++ linux-2.6.8-rc1-mm1-full/include/linux/usb.h	2004-07-18 05:47:51.000000000 +0200
@@ -289,7 +289,7 @@
 
 struct usb_tt;
 
-/**
+/*
  * struct usb_device - kernel's representation of a USB device
  *
  * FIXME: Write the kerneldoc!

