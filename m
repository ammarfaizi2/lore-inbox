Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264958AbUFRBwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264958AbUFRBwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 21:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264955AbUFRBwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 21:52:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:51601 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264958AbUFRBsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 21:48:19 -0400
Date: Thu, 17 Jun 2004 18:47:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext3 jbd needs to wait for locked buffers
Message-Id: <20040617184723.2be98997.akpm@osdl.org>
In-Reply-To: <1087522329.8002.82.camel@watt.suse.com>
References: <1087522329.8002.82.camel@watt.suse.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> wrote:
>
> jbd needs to wait for any io to complete on the buffer before
>  changing the end_io function.

Thanks, I bet that was fun to hunt down.

Same problem in 2.4, although there it looks like it'll just cause a memory
leak.  I guess if an app is mmapping a blockdev we could end up with a
permanently locked page though.

