Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbTKWVsJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 16:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263478AbTKWVsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 16:48:09 -0500
Received: from ozlabs.org ([203.10.76.45]:6574 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263475AbTKWVsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 16:48:07 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16321.11220.891098.198174@cargo.ozlabs.ibm.com>
Date: Mon, 24 Nov 2003 08:51:16 +1100
From: Paul Mackerras <paulus@samba.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix locking in input
In-Reply-To: <20031122155224.GA249@elf.ucw.cz>
References: <20031122155224.GA249@elf.ucw.cz>
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:

> input uses "volatile signed char" as a shared variable between normal
> and interrupt threads (look at _sendbyte()). Thats bad idea, this
> switches it to atomic_t.

This change looks unnecessary to me - we aren't trying to increment or
decrement the variable, just set it and read it.  Reading and writing
individual bytes is atomic on any platform we care about.

Paul.
