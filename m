Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbTAJKOS>; Fri, 10 Jan 2003 05:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbTAJKNE>; Fri, 10 Jan 2003 05:13:04 -0500
Received: from dp.samba.org ([66.70.73.150]:24260 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264790AbTAJKM7>;
	Fri, 10 Jan 2003 05:12:59 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andre Hedrick <andre@linux-ide.org>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: Another idea for simplifying locking in kernel/module.c 
In-reply-to: Your message of "Fri, 10 Jan 2003 01:38:56 -0800."
             <Pine.LNX.4.10.10301100138270.31168-100000@master.linux-ide.org> 
Date: Fri, 10 Jan 2003 21:15:24 +1100
Message-Id: <20030110102144.464272C0B7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.10.10301100138270.31168-100000@master.linux-ide.org> you
 write:
> 
> I'll bite .... what the flip is [unsafe] ??

Use of obsolete (racy) module reference count interface. ie. someone's
upping the reference count with __MOD_INC_USE_COUNT() or
MOD_INC_USE_COUNT(), not "try_module_get()", so we can't tell them
that the module is going away so they couldn't get a reference.

Going through and fixing these up is generally fairly easy.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
