Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267502AbUHDXXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267502AbUHDXXL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 19:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267505AbUHDXXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 19:23:10 -0400
Received: from web53802.mail.yahoo.com ([206.190.36.197]:33930 "HELO
	web53802.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267502AbUHDXW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 19:22:57 -0400
Message-ID: <20040804232252.30644.qmail@web53802.mail.yahoo.com>
Date: Wed, 4 Aug 2004 16:22:52 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: Interesting failures of 'cscope'
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI

  The first failure seems to be a confusion between function declarations and definitions - 
eg for linux-2.6.7, it says FsmNew() is called by drivers/isdn/hisax/fsm.h::CallcNew, thus:

$cscope -d -p9 -L -3 FsmNew
  ...
  drivers/isdn/hisax/fsm.h CallcNew 50 int FsmNew(struct Fsm *fsm, struct FsmNode,*fnlist, int
fncount);
  ...

  but there is no call there, only an external declaration of FsmNew, and no declaration of
CallcNew of any kind whatsoever in that file!


  The second failure appears to be related to an inability to cope with complicated declarations
within a prototype, such of those of type pointer-to-function. For example, the definition:

  struct net_device *alloc_netdev(int sizeof_priv, const char *mask, 
                                         void (*setup)(struct net_device *))

from line 73 of drivers/net/net_init.c, is not recognized by cscope as a valid function definition
and so it does not find the call to kmalloc (or anything else) contained in that function.

$ cscope -d -p9 -L -1 alloc_netdev
<nothing>
$ cscope -d -p9 -L -3 kmalloc | grep alloc_netdev
<nothing>


