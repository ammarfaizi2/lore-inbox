Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbVI1Rwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVI1Rwt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 13:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVI1Rwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 13:52:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:23698 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750825AbVI1Rwt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 13:52:49 -0400
Date: Wed, 28 Sep 2005 18:52:44 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, R.E.Wolff@BitWizard.nl
Subject: Re: [PATCH] remove check_region in drivers-char-specialix.c
Message-ID: <20050928175244.GY7992@ftp.linux.org.uk>
References: <20050928083737.GA29498@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050928083737.GA29498@gollum.tnic>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2005 at 10:37:37AM +0200, Borislav Petkov wrote:
> Hi Andrew,
> 
>    This is also a pretty simple case. We remove the wrapper and make
>    sx__request_io_range return struct resource *. We check its value accordingly
>    in the probing routine. It compiles cleanly here.

NAK.  You've just introduced a pile of leaks - if sx_probe() fails after
that call, you end up with region claimed and not released.
