Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbTELWoh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 18:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbTELWoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 18:44:37 -0400
Received: from corky.net ([212.150.53.130]:54939 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S262722AbTELWof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 18:44:35 -0400
Date: Tue, 13 May 2003 01:57:13 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: 76306.1226@compuserve.com
Cc: alan@lxorguk.ukuu.org.uk, <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <Pine.LNX.4.44.0305130138350.15817-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 May 2003 17:51:25 EDT, Chuck Ebbert said:

> > man dd ?
>
>   "That can be done manually" does not get you the check mark in
> the list of features.  Management wants idiot-resistant security.

It has nothing to do with idiot-resistance.  Why should this multi-write
operation be done in kernel ?  mkswap is a usermode program.  mkfs is a
usermode program.  If you want to have a wipeswap script that copies a
chunk of your /dev/zero to the swap, it should also be in usermode.  Just
run it in wherever rc file you use to swapoff.

However, it'll just give you false sense of security.  First of all, its
hardware dependent.  Second, it won't get wipe in case of a crash (which
is likely to happen when They come to take your disk).

Until linux gets a real encrypted swap (the kind OpenBSD implements), you
can settle for encrypting your whole swap with one random key that gets
lost on reboot.  Encrypted loop dev with a key from /dev/random easily
gives you that.

Download the latest loop-AES from http://loop-aes.sourceforge.net/ and
follow the "Encrypting swap on 2.4 kernels" section in README.


