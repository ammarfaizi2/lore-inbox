Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbTDUSxZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTDUSxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:53:25 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:44298 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261977AbTDUSw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:52:28 -0400
Date: Mon, 21 Apr 2003 20:04:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Olien <dmo@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, marcelo@conectiva.com.br,
       alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DAC960 open with O_NONBLOCK
Message-ID: <20030421200430.A11175@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Olien <dmo@osdl.org>, marcelo@conectiva.com.br,
	alan@redhat.com, linux-kernel@vger.kernel.org
References: <20030421172402.GA26863@osdl.org> <20030421183752.A8782@infradead.org> <20030421190111.GA27126@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030421190111.GA27126@osdl.org>; from dmo@osdl.org on Mon, Apr 21, 2003 at 12:01:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 12:01:11PM -0700, Dave Olien wrote:
> > What applications?
> 
> John Kamp has run across a libhd applcation from Suse that hit this bug.
> It's some kind of hardware detection application.  It opens devices with
> O_NONBLOCK.  But, it doesn't in fact use the DAC960 pass-through commands.

Do you have source to it?

> The Mylex web page has a RAID management application for DAC960 on Linux that
> is available only in BINARY form.  Unfortunately, it requires
> a Windows front-end to provide a GUI.  So, I haven't actually experimented
> with it. If any application uses the pass-through commands, this would likely
> be it.  But since no one has complained about this being broken, it may
> indicate no one is using this application.

Hmm, breaking it wouldn't be nice, but if they're not willing to
release an updated version we'll just need a LD_PRELOAD wrapper
that maps the open to a new mangment device.

> The pass-through behavior could be made available either through
> a /proc or a sysfs file.

My preference would be a char device (miscdev)

> A related question, why does linux 2.5 continue to have a "struct file *"
> argument to driver release methods? As far as I can tell, that argument
> is always NULL?

->release will change to struct gendisk * at some point.  Touching
it before to just remove the struct file * sounds like a bad idea.

