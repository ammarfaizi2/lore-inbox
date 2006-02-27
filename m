Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWB0RsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWB0RsO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 12:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWB0RsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 12:48:14 -0500
Received: from postage-due.permabit.com ([66.228.95.230]:22250 "EHLO
	postage-due.permabit.com") by vger.kernel.org with ESMTP
	id S1751436AbWB0RsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 12:48:13 -0500
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.31 hangs, no information on console or serial port
References: <7yirr8hh0z.fsf@questionably-configured.permabit.com>
	<20060221152949.GA31273@kvack.org>
	<7yfym4lqhh.fsf@questionably-configured.permabit.com>
	<20060227163944.GB18291@kvack.org>
From: David Golombek <daveg@permabit.com>
Date: 27 Feb 2006 12:48:06 -0500
In-Reply-To: <20060227163944.GB18291@kvack.org>
Message-ID: <7yd5h8u209.fsf@questionably-configured.permabit.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Permabit-Spam: SKIPPED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@kvack.org> writes:
> On Mon, Feb 27, 2006 at 11:24:10AM -0500, David Golombek wrote:
> > We're beginning to suspect that a hung loopback NFS mount might be to
> > blame, although we can't reproduce this trivially.  Is there anyway in
> > which a mount that was behaving badly could affect the kernel in this
> > manner?
> 
> Loopback NFS can deadlock in trying to free memory when writing back
> dirty pages.  Use mount --bind instead.

Unfortunately, --bind is not an option for us.  The custom nfs-server
is actually a protocol adapter, mapping a custom filesystem spread
across a cluster of machines into NFS.  We have the loopback mount in
order to provide CIFS access via samba.  Looking at
http://www.ussg.iu.edu/hypermail/linux/kernel/0407.3/0297.html

it certainly does seem like we're susceptible to this failure and are
looking at memory usage at the time of the crash.

Thanks,
Dave

