Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbUDGV5V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 17:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUDGV5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 17:57:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5358 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264191AbUDGV4g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 17:56:36 -0400
Date: Wed, 7 Apr 2004 22:56:35 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] remove %n printf format specifier support from vsprintf.c
Message-ID: <20040407215634.GT31500@parcelfarce.linux.theplanet.co.uk>
References: <20040407211814.GV28202@mulix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407211814.GV28202@mulix.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 12:18:15AM +0300, Muli Ben-Yehuda wrote:
> Hi, 
> 
> This patch removes support for the %n format specifier from
> vsprintf, remove the sole use of %n in the kernel, fixes seq_printf to
> return the number of characters written rather than 0 on success
> (thus getting rid of %n), and fixes the only two callers of seq_printf
> who bothered to look at the return value.  
> 
> The printf man page has this to say about '%n': 
> 
> "The number of characters written so far is stored into the integer
> indicated by the int * (or variant) pointer argument.  No argument is
> converted." 
> 
> Very little code actually uses %n for that. These days, %n has a much
> more common use - in printf format string exploits. Since there's only
> one user of %n in the kernel, this patch removes support for it and
> fixes the user. To preempt the obvious argument, I agree that printk
> should look and behave as much as possible as printf - except where
> it's harmful. We don't support floating point, for example, and I
> doubt we should support %n - although I don't strongly care one way or
> another. 

IMO that's wrong - if we get untrusted format we are screwed anyway (shove
enough %s and you are pretty much guaranteed to get an oops) and it's more
than likely that check for return value being negative will be forgotten.
