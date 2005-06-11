Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVFKQY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVFKQY1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 12:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVFKQY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 12:24:27 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:58320 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261661AbVFKQYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 12:24:23 -0400
Date: Sat, 11 Jun 2005 18:24:22 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Assuming NULL
Message-ID: <Pine.LNX.4.61.0506111823440.19223@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi developers,



some places in fs/*.c have conditions like

(namei.c, 238, in "int permission()"):
        if(inode->i_op && inode->i_op->permission)

Others just have
(namei.c, 813, in "int fastcall link_path_walk()"):
        if(!inode->i_op->lookup)

My question is: Which one is right wrt the case "i_op ==/!= NULL"?
There are two ways:

- the kernel assumes i_op (and similar) is always non-NULL
  => then we can remove a lot of checks, like the first example above

- the kernel does not assume...
  => then we need some extra checks, like in the second example above



Jan Engelhardt                                                               
--                                                                            
| Gesellschaft fuer Wissenschaftliche Datenverarbeitung Goettingen,
| Am Fassberg, 37077 Goettingen, www.gwdg.de
