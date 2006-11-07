Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932673AbWKGOaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673AbWKGOaL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 09:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbWKGOaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 09:30:11 -0500
Received: from rusty.kulnet.kuleuven.ac.be ([134.58.240.42]:41893 "EHLO
	rusty.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S932673AbWKGOaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 09:30:09 -0500
Message-ID: <4550986C.8020802@cc.kuleuven.be>
Date: Tue, 07 Nov 2006 15:30:04 +0100
From: Rik Bobbaers <Rik.Bobbaers@cc.kuleuven.be>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org
Subject: very small code cleanup
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey all,

in mm/mlock.c , mm is defined as vma->vm_mm, why not use that one for 
the decrement of pages?

proposed patch:
---------------
--- mm/mlock.c~ 2006-11-04 02:33:58.000000000 +0100
+++ mm/mlock.c  2006-11-07 15:23:48.000000000 +0100
@@ -65,7 +65,7 @@ success:
                         ret = make_pages_present(start, end);
         }

-       vma->vm_mm->locked_vm -= pages;
+       mm->locked_vm -= pages;
  out:
         if (ret == -ENOMEM)
                 ret = -EAGAIN;

---------------

tnx...

-- 
harry
aka Rik Bobbaers

K.U.Leuven - LUDIT          -=- Tel: +32 485 52 71 50
Rik.Bobbaers@cc.kuleuven.be -=- http://people.linux-vserver.org/~harry

thinking always leads to conclusions... and those can be extremely dangerous
-- me ;)

Disclaimer: http://www.kuleuven.be/cwis/email_disclaimer.htm

