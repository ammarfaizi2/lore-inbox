Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbWFTIhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWFTIhy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbWFTIhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:37:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9882 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965050AbWFTIhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:37:53 -0400
Date: Tue, 20 Jun 2006 01:37:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: linux-kernel@vger.kernel.org, hal@lists.freedesktop.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: USB/hal: USB open() broken? (USB CD burner underruns, USB HDD
 hard resets)
Message-Id: <20060620013741.8e0e4a22.akpm@osdl.org>
In-Reply-To: <20060619082154.GA17129@rhlx01.fht-esslingen.de>
References: <20060619082154.GA17129@rhlx01.fht-esslingen.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 10:21:54 +0200
Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:

> I'm having severe issues with cdrecord aborting with "buffer underrun"
> message, *always*. Problem nailed, see below.

[hald polling causes cdrecord to go bad on a USB CD drive]

One possible reason is that we're shooting down the device's pagecache by
accident as a result of hald activity.  This shouldn't happen, but still.
Could you please do

`watch -n1 cat /proc/meminfo' and/or `vmstat 1'

then run cdrecord

then wait a bit

then run hald, see if the amount of pagecache (/proc/meminfo:Buffers or
/proc/meminfo:Cached) suddenly decreases.

If the answer is "no" then I guess there's some unpleasant interaction
happening at the USB level

