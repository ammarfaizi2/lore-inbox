Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbULIXmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbULIXmB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 18:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbULIXmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 18:42:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:39134 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261677AbULIXl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 18:41:56 -0500
Date: Thu, 9 Dec 2004 15:41:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: akpm@osdl.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB fixes for 2.6.10-rc3
In-Reply-To: <20041209230900.GA6091@kroah.com>
Message-ID: <Pine.LNX.4.58.0412091538510.31040@ppc970.osdl.org>
References: <20041209230900.GA6091@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Dec 2004, Greg KH wrote:
> 
> Greg Kroah-Hartman:
>   o USB: fix another sparse warning in the USB core

This one looks incorrect.

The code doesn't _fix_ any warnings. It just shuts them up, without fixing 
anything at all.

The fact is  "le16_to_cpu()" should act on a le16 value, and sparse 
_should_ complain if you pass it the wrong value and ask sparse to check 
with -Wbitwise.

But instead of fixing "config->wTotalLength" to be of type "le16", which 
would _fix_ the problem, you shut up the valid warning.

If you don't want to see those warnings, don't use -Wbitwise. But don't 
just shut them up.

		Linus
