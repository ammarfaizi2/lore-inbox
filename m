Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265597AbTF3Cnn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 22:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265522AbTF3Cnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 22:43:43 -0400
Received: from dp.samba.org ([66.70.73.150]:6843 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265597AbTF3Cnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 22:43:42 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: support@moxa.com.tw, linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] remove two unused variables from mxser.c 
In-reply-to: Your message of "Sat, 28 Jun 2003 04:39:36 +0200."
             <20030628023935.GQ24661@fs.tum.de> 
Date: Mon, 30 Jun 2003 12:01:58 +1000
Message-Id: <20030630025802.E85162C220@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030628023935.GQ24661@fs.tum.de> you write:
> On Fri, Jun 20, 2003 at 02:31:06PM +1000, Rusty Russell wrote:
> > In message <20030619231222.GF29247@fs.tum.de> you write:
> > > The patch below removes two unused variables from drivers/char/mxser.c .
> > 
> > While you're there, would you fix the init returning "-1" for no good
> > reason at the bottom, too?  (I don't think they really meant EPERM).
> 
> There is at least one other driver under drivers/char/ doing the 
> same...
> 
> Which return code do you suggest?

Looking at the code, there are other problems.

The last thing to fail (which triggers this -1 return) is
tty_register_driver(mxvar_sdriver): so keep that return code and use
it.

But they do put_tty_driver(mxvar_sdriver) in the failure path, which
seems wrong, too...

Good luck!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
