Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWFBWlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWFBWlt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 18:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWFBWlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 18:41:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62387 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932179AbWFBWlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 18:41:49 -0400
Date: Fri, 2 Jun 2006 15:41:21 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <gregkh@suse.de>
Cc: lcapitulino@mandriva.com.br, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk, linux-usb-devel@lists.sourceforge.net,
       zaitcev@redhat.com
Subject: Re: [PATCH 8/11] usbserial: pl2303: Ports tty functions.
Message-Id: <20060602154121.d3f19cbe.zaitcev@redhat.com>
In-Reply-To: <20060602205014.GB31251@suse.de>
References: <1149217397133-git-send-email-lcapitulino@mandriva.com.br>
	<1149217398434-git-send-email-lcapitulino@mandriva.com.br>
	<20060602205014.GB31251@suse.de>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2006 13:50:14 -0700, Greg KH <gregkh@suse.de> wrote:
> On Fri, Jun 02, 2006 at 12:03:14AM -0300, Luiz Fernando N.Capitulino wrote:

> >   2. The new pl2303's set_termios() can (still) sleep. Serial Core's
> >      documentation says that that method must not sleep, but I couldn't find
> >      where in the Serial Core code it's called in atomic context. So, is this
> >      still true? Isn't the Serial Core's documentation out of date?
> 
> If this is true then we should just stop the port right now, as the USB
> devices can not handle this.  They need to be able to sleep to
> accomplish this functionality.
> 
> Russell, is this a requirement of the serial layer?  Why?

Shouldn't it be all right to schedule the change at the moment of
that call and have it happen later? Resisting a temptation to abuse
keventd and schedule_work and using a tasklet may help with latency
enough to make this tolerable.

I'm sure that a generic mechanism to drive asynchronous usb_control_msg
is going to be required as well for this project. The pl2303 is just
lucky to avoid it.

-- Pete
