Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265180AbSJRPxX>; Fri, 18 Oct 2002 11:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265189AbSJRPxX>; Fri, 18 Oct 2002 11:53:23 -0400
Received: from cs.columbia.edu ([128.59.16.20]:29413 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S265180AbSJRPxW>;
	Fri, 18 Oct 2002 11:53:22 -0400
Subject: understanding devpts_pty_new/kill
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1034956748.2256.62.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2 (Preview Release)
Date: 18 Oct 2002 11:59:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to understand how the path those functions take to be called.

>From a basic understanding, is that we register f_ops for tty's and
ptys.  So we register tty_open for tty's which includes ptmx. 

therefore when we open ptmx, tty_open gets called, we do the code for
PTMX, which calls devpts_pty_new() which creates the appropriate
enteries in /dev/pts.  These f_ops are registered in chrdevs struct
(from fs/devices.c)

I'm a little more hazy on devpts_pty_kill.  That seems to similiar
(except it's in pty_close, in pty.c) which is part of a much larger "tty
driver" structure and is the "close" member of that structure.  This
structure is then registered.  Then basically, it's also registered w/
tty_fops, but tty_release calls tty->driver.close.

Is this a correct understanding, or is there more going on behind the
scenes?

thanks,

shaya potter

