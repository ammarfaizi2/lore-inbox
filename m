Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271129AbTGPVG0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 17:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271126AbTGPVGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 17:06:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:41088 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271129AbTGPVFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 17:05:43 -0400
Date: Wed, 16 Jul 2003 14:13:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-Id: <20030716141320.5bd2a8b3.akpm@osdl.org>
In-Reply-To: <20030716210253.GD2279@kroah.com>
References: <20030716184609.GA1913@kroah.com>
	<20030716130915.035a13ca.akpm@osdl.org>
	<20030716210253.GD2279@kroah.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> > So we'll need to come up with some standardised way of presenting a dev_t
> > to the user.  Presumably that will just be
> > 
> > 	sprintf(buf, "%d:%d", major(dev), minor(dev));
> > 	
> > But if we do this, will it break your existing stuff?
> 
> No, I don't think there are any users of udev right now :)
> 
> I wouldn't mind the ':' being there, makes my life a bit easier, but for
> some reason Al Viro didn't want to do that a long time ago...
> 
> If we put the ':' in there, it protects userspace from having to deal
> with different sized dev_t, so that really makes sense.

OK, I think I'll make it so and hope he doesn't notice ;)

The new dev_t encoding is a bit weird because we of course continue to
support the old 8:8 encoding.  I think the rule is: "if the top 32-bits are
zero, it is 8:8, otherwise 32:32".  We can express this nicely with
"%u:%u".

Now I need to go hunt down all those places where I added casts to unsigned
longs in printks.  hrm.

