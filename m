Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266210AbUFJGrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266210AbUFJGrB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 02:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266211AbUFJGrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 02:47:01 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:25004 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266182AbUFJGqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 02:46:51 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/3] Couple of sysfs patches
Date: Thu, 10 Jun 2004 01:40:29 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200406090221.24739.dtor_core@ameritech.net> <200406091754.23303.dtor_core@ameritech.net> <20040609231920.GA9132@kroah.com>
In-Reply-To: <20040609231920.GA9132@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406100140.30621.dtor_core@ameritech.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Description: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 June 2004 06:19 pm, Greg KH wrote:
> On Wed, Jun 09, 2004 at 05:54:23PM -0500, Dmitry Torokhov wrote:
> > On Wednesday 09 June 2004 05:45 pm, Greg KH wrote:
> > > On Wed, Jun 09, 2004 at 05:32:28PM -0500, Dmitry Torokhov wrote:
> > > > Actually, I myself want someting else -
> > > > 
> > > > int platform_device_register_simple(struct platform_device **ppdev,
> > > > 				    const char *name, int id)
> > > > 
> > > > It will allocate platform device, set name and id and release function to
> > > > platform_device_simple_release which in turn will be hidden from outside
> > > > world. Since the function does allocation for user is should prevent the
> > > > abuse you were concerned about.
> > > 
> > > Ok, that sounds good.  I'll take patches for that kind of interface.
> > > 
> > > But have the function return the pointer, like the class_simple
> > > functions work.  Not the ** like you just specified.
> > 
> > I want to do both allocation + registration in one shot and I knowing
> > the error code may be important to users.
> 
> That's fine to do.  Again, look at how the class_simple_create()
> function works.  If an error happens, convert it to ERR_PTR() and return
> that.  The caller can check it with IS_ERR() and friends.

I apologize, I wrote above hastily, without looking at class_simple_create
implementation.

Please take a look at the new version of patces. I changed the order so
whitespace changes are on 3rd place to ease merging. The patches are against
tonight's bk pull from Linus' tree.

There is also 4th patch that allows a device driver to register/unregister
a new device on the same bus from driver's probe/remove routine. I need this
functionality for implementing pass-through ports, I tried to work around
sysfs limitation but it was too ugly for words.

Please let me know what you think.
 
-- 
Dmitry
