Return-Path: <linux-kernel-owner+w=401wt.eu-S932458AbXAGJd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbXAGJd5 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 04:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbXAGJd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 04:33:57 -0500
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:43408 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932458AbXAGJd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 04:33:56 -0500
Subject: Re: [DISCUSS] Making system calls more portable.
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Amit Choudhary <amit2030@yahoo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <722886.55398.qm@web55601.mail.re4.yahoo.com>
References: <722886.55398.qm@web55601.mail.re4.yahoo.com>
Content-Type: text/plain
Date: Sun, 07 Jan 2007 01:33:50 -0800
Message-Id: <1168162430.26562.12.camel@dsl081-166-245.sea1.dsl.speakeasy.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-07 at 00:15 -0800, Amit Choudhary wrote:
> 1. Invoke a system call using its name. Pass its name to the kernel as an argument of syscall() or
> some other function. Probably may make the invocation of the system call slower. If the name
> doesn't match in the kernel then an error can be returned.
> 
> 2. Create a /proc entry that will return the number of the system call given its name. This number
> can then be used to invoke the system call.

Your argument has a built-in assumption that, whereas syscall numbers do
collide, syscall names will not. This assumption is not true; people
will quite often pick the same name for something independent of each
other.

Additionally, the proposed solutions will require a dramatic increase in
memory, to store a static string name for each syscall, and a marked
increase in CPU usage, to do string hashing and matching for each
syscall invocation (and these can occur very often). This overhead is
hard to justify just to support custom vendor kernels, as Rene pointed
out in a separate reply.

> These approaches will also remove the dependency from user space header file that contains the
> mapping from the system call name to its number. I hope that I made some sense.

I thought that this file was "shipped upwards" by the kernel already, as
a sanitized header?

-- Vadim Lobanov


