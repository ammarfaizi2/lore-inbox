Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263272AbTJKJ4a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 05:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbTJKJ4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 05:56:30 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:19430 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263272AbTJKJ43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 05:56:29 -0400
Date: Sat, 11 Oct 2003 11:56:26 +0200 (MEST)
Message-Id: <200310110956.h9B9uQjv004494@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: rusty@rustcorp.com.au
Subject: Re: 2.6.0-test6 module autoloading and reference counting broken?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Oct 2003 15:25:20 +1000, Rusty Russell wrote:
>In message <16253.27644.578089.345998@gargle.gargle.HOWL> you write:
>> FYI,
>> 
>> I'm seeing incorrect reference counting behaviour and module
>> loading semi-failures in 2.6.0-test6.
>> 
>> I have a misc char driver module which announces an alias
>> via a MODULE_ALIAS("char-major-10-<nnn>") declaration.
>> 
>> The first attempt by user-space to open the device node fails
>> with ENODEV. However, afterwards the module _is_ loaded and its
>> use count is 1 even though the user-space open() failed.
>
>Sounds like a refcount bug somewhere (in your module, maybe?).
>There's nothing magic about modules loaded via kmod, even via
>aliases, unless there's a bug in drivers/char/misc.c...

test6 did introduce a bug in drivers/char/misc.c causing
the problems I described. It's been fixed in test7.

/Mikael
