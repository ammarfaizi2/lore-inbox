Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265789AbUF2QBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265789AbUF2QBA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 12:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbUF2QBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 12:01:00 -0400
Received: from mproxy.gmail.com ([216.239.56.253]:1402 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S265789AbUF2QA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 12:00:59 -0400
Message-ID: <8783be66040629090027010876@mail.gmail.com>
Date: Tue, 29 Jun 2004 09:00:36 -0700
From: Ross Biro <ross.biro@gmail.com>
To: David Ashley <dash@xdr.com>
Subject: Re: Cached memory never gets released
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200406291507.i5TF7NIJ027740@xdr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200406291507.i5TF7NIJ027740@xdr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First it's absolutely normal for cache to fill up all available
memory.  What's not normal is to not free unused cache when memory is
needed.

My best guess is that this isn't a kernel problem, but a bug in flash
and all that memory really is used.  The next step I would do is go
through all of the processes and see how much memory they are all
using.  For example has flashed been mapping files into memory and not
closing them or freeing the memory?

The first thing I would do is run top on a system that you think is
near dying and sort the processes by memory usage.  If you find a
process using lots of memory, that is your culprit.  In any case,
attach the output of ps auxw from a system that is out of memory.
