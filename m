Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269293AbUI3OTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269293AbUI3OTd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 10:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269285AbUI3OTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 10:19:33 -0400
Received: from hera.cwi.nl ([192.16.191.8]:63724 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S269293AbUI3OTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 10:19:14 -0400
Date: Thu, 30 Sep 2004 16:19:05 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andries.Brouwer@cwi.nl, akpm@osdl.org, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] overcommit symbolic constants
Message-ID: <20040930141905.GA4077@apps.cwi.nl>
References: <UTC200409301341.i8UDfRi02421.aeb@smtp.cwi.nl> <1096548791.19269.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096548791.19269.5.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 01:53:12PM +0100, Alan Cox wrote:
> On Iau, 2004-09-30 at 14:41, Andries.Brouwer@cwi.nl wrote:
> > Played a bit with overcommit the past hour.
> > Am not entirely satisfied with the no overcommit mode 2 -
> > programs segfault when the system is close to that boundary.
> 
> Not really a suprise. Very few programs handle stack growth faults.
> Hence the docs comment about mmapping stacks privately for critical
> code.

Most utilities do not expect to be oom-killed, but they do not
expect to be killed by segfault because of stack shortage either.
So avoiding the oom-kill and getting segfaults is no improvement
in my eyes.

A few days ago I remarked that 2 is no good when there is no swap.
OK. So, more modest aim - tighten things only in case there is
plenty of swap. I like to return NULL for malloc(), that is
something a good program tests for. I hate to fail a stack grow.
So, must play a bit more, see whether I can find a mode much
stricter than 0 that is still suitable as a general working
environment for everybody.


Andries


