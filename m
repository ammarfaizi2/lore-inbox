Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbTDRRH2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 13:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTDRRH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 13:07:28 -0400
Received: from hera.cwi.nl ([192.16.191.8]:64998 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263169AbTDRRHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 13:07:06 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 18 Apr 2003 19:19:01 +0200 (MEST)
Message-Id: <UTC200304181719.h3IHJ1i03344.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, torvalds@transmeta.com
Subject: Re: [PATCH] struct loop_info64
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Linus Torvalds <torvalds@transmeta.com>

    We should literally have the rule that any user-visible data structures 
    cannot use _any_ types other than u8/u16/u32/u64 (and _maybe_ the signed 
    ones, if there is any real reason to).

I agree very much with the statement that basic types
that occur in the kernel API should be explicitly given.
Not ino_t or __old_dev_t but int or long.

I agree less with the statement that they must be u32 instead of int.
My main reason is historical: the Unix interface is defined in terms
of char/int/long.

    > +struct loop_info64 {
    > +    int           lo_number;        /* ioctl r/o */
    > +    unsigned long long lo_device;         /* ioctl r/o */
    > +    unsigned long       lo_inode;         /* ioctl r/o */
    > +    unsigned long long lo_rdevice;         /* ioctl r/o */

    Make these be explicitly sized, and try to put the 64-bit members at the 
    beginning to avoid alignment and structure packing problems.

OK - will do.

(So far compatibility was so good that a private copy of the old
definition of struct loop_info could be used where the kernel
expects a struct loop_info64. Making more changes to struct loop_info64
diminishes compatibility, but

    Any reason to keep an "offset" as "int"?

changing the type of offset destroys compatibility anyway.)

Andries
