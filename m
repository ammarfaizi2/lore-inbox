Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161247AbWJ3Ky4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161247AbWJ3Ky4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 05:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161254AbWJ3Ky4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 05:54:56 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:44746 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161247AbWJ3Kyz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 05:54:55 -0500
Date: Mon, 30 Oct 2006 10:54:51 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
Subject: Re: [PATCH] semaphore.h: add missing "sleepers = 0" initialization
Message-ID: <20061030105451.GN29920@ftp.linux.org.uk>
References: <Pine.LNX.4.64.0610300540140.7056@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610300540140.7056@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 05:43:14AM -0500, Robert P. J. Day wrote:
> 
>   Add the missing initialization of "sleepers" to 0 in two semaphore
> initialization macros.

Umm...  What the hell for?  Both for struct initializer and for
compound literals all named fields that had not been mentioned
get initialized as they would for static objects.  So that's
simply adding more work to parser for no reason whatsoever.

There are only two cases when something is left uninitialized:
	* auto variable with no initializer whatsoever
	* padding and unnamed members

That's it.
