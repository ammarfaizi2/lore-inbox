Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbTIPThw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 15:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbTIPThw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 15:37:52 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:1651 "EHLO
	mwinf0303.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262486AbTIPThv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 15:37:51 -0400
Message-ID: <3F6767AE.4090907@wanadoo.fr>
Date: Tue, 16 Sep 2003 21:42:38 +0200
From: Remi Colinet <remi.colinet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test5 : Bug in include/linux/input.h ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While reading the input code, I found the following error in 
drivers/linux/input.h :

--- include/linux/input.h       2003-08-23 01:54:59.000000000 +0200
+++ include/linux/input.h.mod   2003-09-16 21:38:10.000000000 +0200
@@ -751,7 +751,7 @@
 #define LONG(x) ((x)/BITS_PER_LONG)

 #define INPUT_KEYCODE(dev, scancode) ((dev->keycodesize == 1) ? 
((u8*)dev->keycode)[scancode] : \
-       ((dev->keycodesize == 1) ? ((u16*)dev->keycode)[scancode] : 
(((u32*)dev->keycode)[scancode])))
+       ((dev->keycodesize == 2) ? ((u16*)dev->keycode)[scancode] : 
(((u32*)dev->keycode)[scancode])))

 #define init_input_dev(dev)    do { INIT_LIST_HEAD(&((dev)->h_list)); 
INIT_LIST_HEAD(&((dev)->node)); } while (0)

Remi

