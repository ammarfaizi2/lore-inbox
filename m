Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTJUArR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 20:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbTJUArR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 20:47:17 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:2950 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262874AbTJUArM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 20:47:12 -0400
Date: Tue, 21 Oct 2003 02:47:09 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide write barrier support
Message-ID: <20031021004709.GA11523@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3F902E0A.5060908@colorfullife.com> <20031017180612.GB8230@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031017180612.GB8230@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Oct 2003, Jens Axboe wrote:

> On Fri, Oct 17 2003, Manfred Spraul wrote:
> > Jens wrote:
> > 
> > >The problem is that as far as I can see the best way to make fsync
> > >really work is to make the last write a barrier write. That
> > >automagically gets everything right for you - when the last block goes
> > >to disk, you know the previous ones have already. And when the last
> > >block completes, you know the whole lot is on platter.
> > >
> > Are you sure?
> > What prevents the io scheduler from writing the last block before other 
> > blocks?
> 
> Very sure, the io scheduler will never put the barrier write before
> previously comitted writes. So yes, it will work as described.

If the "last block" is special however (containing a "complete" marker
for instance), the order needs to be:

write1 write2 write3 write4 barrier write-last barrier

This will guarantee write-last will happen after write4.

The drive is free to permute the order of write1 ... write4, no?

Manfred, was that your idea?

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
