Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318221AbSHZULv>; Mon, 26 Aug 2002 16:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318230AbSHZULu>; Mon, 26 Aug 2002 16:11:50 -0400
Received: from mnh-1-19.mv.com ([207.22.10.51]:20997 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S318221AbSHZULu>;
	Mon, 26 Aug 2002 16:11:50 -0400
Message-Id: <200208262119.QAA03617@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org
Subject: copy_to_user to a kmapped address
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 26 Aug 2002 16:19:37 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this (in file_read_actor) bogus or am I missing something?

1621            kaddr = kmap(page);
1622            left = __copy_to_user(desc->buf, kaddr + offset, size);
1623            kunmap(page);

It seems to me that copy_to_user should be able to assume that the destination
address is a user address.

This is biting me because I'm moving the UML kernel into a separate address
space, so there's no way, in general, to tell the difference between a kernel
address and a userspace address.

				Jeff

