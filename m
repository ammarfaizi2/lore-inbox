Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUDCKu0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 05:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbUDCKu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 05:50:26 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:30320 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261682AbUDCKuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 05:50:18 -0500
Date: Sat, 3 Apr 2004 02:48:26 -0800
From: Jeremy Higdon <jeremy@sgi.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040403104826.GA737325@sgi.com>
References: <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com> <4066191E.4040702@yahoo.com.au> <40662108.40705@pobox.com> <20040328135124.GA32597@mail.shareable.org> <40670A36.3000005@pobox.com> <20040328173623.GA1087@mail.shareable.org> <20040402101108.GA752170@sgi.com> <20040402161149.GA32483@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402161149.GA32483@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 05:11:49PM +0100, Jamie Lokier wrote:
> Jeremy Higdon wrote:
> > > This is what I mean: turn off write cacheing, and performance on PATA
> > > drops because of the serialisation and lost inter-command time.
> > 
> > Since you have to write the sectors in order (well, you don't have
> > to, but the drives all do this), you lose a rev between each write
> > when you don't queue commands or have write cacheing.
> 
> I don't see how the driver can write the sectors out of order, if
> there is no TCQ (we're talking PATA) and every write must be committed
> before it's acknowledged (write cache disabled).
>
> > > With TCQ-on-write, you can turn off write cacheing and in theory
> > > performance doesn't have to drop, is that right?
> > 
> > Correct.  I have proven this to my satisfaction.
> 
> Are you refuting the following assertion by Eric D. Mudama's, based on
> your measurements?  In other words, are ATA's 32 TCQ slots enough to
> eliminate the performance advantage of write cacheing?

I must apologize.  I had thought the context was SCSI, but now I
see that it is linux-ide.  So please disregard comments about command
queueing.  If you have write cache disabled and no TCQ (latter is common,
former may or may not be), you want to write as big a chunk as you can.

I'm sorry about the confusion.

jeremy
