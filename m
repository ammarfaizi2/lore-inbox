Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbUBREyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbUBREyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:54:46 -0500
Received: from zeus.kernel.org ([204.152.189.113]:65185 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263742AbUBREyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:54:45 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Matthew Rench <lists@pelennor.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem rmmod'ing module 
In-reply-to: Your message of "Tue, 17 Feb 2004 15:38:58 MDT."
             <20040217153858.A11859@pelennor.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 Feb 2004 15:06:21 +1100
Message-ID: <7711.1077077181@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004 15:38:58 -0600, 
Matthew Rench <lists@pelennor.net> wrote:
>I'm getting some strange behavior while trying to rmmod a module from my
>2.4.21 kernel. Each call to "rmmod" segfaults, leaving the module usage count
>incremented.

kernel/module.c bumps the use count at the start of each query, to
prevent the module being removed while it is being queried.  The use
count is droped at the end of normal query processing, but
kernel/module.c is breaking and leaving the raised use count.

>When I strace rmmod, the last few lines are:
>
>  query_module(NULL, QM_MODULES, { /* 5 entries */ }, 5) = 0
>  query_module("serial", QM_INFO, {address=0xd8816000, size=43620, flags=MOD_RUNNING, usecount=14}, 16) = 0
>  query_module( <unfinished ...>
>  +++ killed by SIGSEGV +++

Information about the second module in the chain (after "serial") is
corrupt.  What does lsmod report?

You should have several oops reports in your syslog.  Run the first two
through ksymoops and send in the ksymoops output.

