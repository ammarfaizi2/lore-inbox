Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWDEWrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWDEWrp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 18:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWDEWrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 18:47:45 -0400
Received: from [67.40.69.52] ([67.40.69.52]:2801 "EHLO morpheus")
	by vger.kernel.org with ESMTP id S932111AbWDEWrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 18:47:45 -0400
Subject: Re: Issues with symbol names
From: Kristis Makris <kristis.makris@asu.edu>
To: Andreas Schwab <schwab@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <jeirpn7k6i.fsf@sykes.suse.de>
References: <1144268838.8306.16.camel@syd.mkgnu.net>
	 <jeirpn7k6i.fsf@sykes.suse.de>
Date: Wed, 05 Apr 2006 15:26:33 -0700
Message-Id: <1144275993.2785.25.camel@syd.mkgnu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-06 at 00:05 +0200, Andreas Schwab wrote:
> Kristis Makris <kristis.makris@asu.edu> writes:
> 
> > My goal here is to use /proc/kallsyms to determine the size of a function
> > image at runtime.
> 
> The size is also recorded in the symbol table.

Do you mean the vmlinux image ? That is not the case for modules that
were dynamically loaded.

This is when problems begin. If one loads a module that happens to be
placed in memory that originally belonged to the __init functions,
then /proc/kallsyms will still report them and throw off this logic. And
perhaps the original module file won't be around to try and get the
function sizes from it.

I suppose I'd rather rely on computing this size from runtime
information...

