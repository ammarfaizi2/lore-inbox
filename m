Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264677AbUD1FnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264677AbUD1FnA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 01:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264679AbUD1FnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 01:43:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:60802 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264677AbUD1Fm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 01:42:59 -0400
Date: Tue, 27 Apr 2004 22:42:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Brad Allen <Ulmo-Usenet@Usenet.Q.Net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: allocation failures with CBQ bandwidth limiting & high net use
 (was Re: Filesystem kernel hangup, 2.6.3 (bad: scheduling while atomic!))
Message-Id: <20040427224239.11a59b84.akpm@osdl.org>
In-Reply-To: <20040427.213919.884032925.ulmo-u@Q.Net>
References: <20040222164941.D6046@foo.ardendo.se>
	<20040223121959.A8354@infradead.org>
	<1077543963.1246.20.camel@harrier.lucky.linux.kernel>
	<20040427.213919.884032925.ulmo-u@Q.Net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Allen <Ulmo-Usenet@Usenet.Q.Net> wrote:
>
>  My MTU for GbE (e1000) is 9000, and NFS block size 8192 bytes.
>  That GbE is a consumer grade Intel model.
> ....
>  swapper: page allocation failure. order:3, mode:0x20

The kernel simply doesn't have a hope of being able to find eight
physically-contiguous free pages at interrupt time.

You'll get some benefit from increasing /proc/sys/vm/min_free_kbytes

But it's beginning to look like we need separately-managed higher-order
page pools for this.  At least.

