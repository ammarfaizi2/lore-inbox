Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVI2BKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVI2BKb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 21:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbVI2BKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 21:10:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:3012 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932076AbVI2BKa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 21:10:30 -0400
Date: Thu, 29 Sep 2005 02:10:26 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, R.E.Wolff@BitWizard.nl
Subject: Re: [PATCH] remove check_region in drivers-char-specialix.c
Message-ID: <20050929011026.GO7992@ftp.linux.org.uk>
References: <20050928083737.GA29498@gollum.tnic> <20050928175244.GY7992@ftp.linux.org.uk> <20050928222822.GA14949@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050928222822.GA14949@gollum.tnic>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 12:28:22AM +0200, Borislav Petkov wrote:
> Andrew told me already today that Jeff[1] had sent a patch fixing all that. To
> prevent the leaks he's calling sx_release_io_range(bp) in every check before
> exiting sx_probe so this seems correct. A small question though: After calling
> sx_request_io_range() in the if-statement on line 499 is it ok to call
> sx_request_io_range() for a second time in a row on line 587?  I think in
> this case the second call has to go, no?
> 
> [1]rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git

Huh?  I don't see any specialix patches in that repository right now...

But yes, after successful request_region() you shouldn't call it again -
that would simply fail.
