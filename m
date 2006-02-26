Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWBZKPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWBZKPS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 05:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWBZKPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 05:15:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21672 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751301AbWBZKPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 05:15:17 -0500
Date: Sun, 26 Feb 2006 02:14:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert serial_core oopses to BUG_ON
Message-Id: <20060226021414.6a3db942.akpm@osdl.org>
In-Reply-To: <20060226100518.GA31256@flint.arm.linux.org.uk>
References: <20060226100518.GA31256@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> Calling serial functions to flush buffers, or try to send more data
>  after the port has been closed or hung up is a bug in the code doing
>  the calling, not in the serial_core driver.
> 
>  Make this explicitly obvious by adding BUG_ON()'s.

If we make it

	if (!info) {
		WARN_ON(1);
		return;
	}

will that allow people's kernels to limp along until it gets fixed?
