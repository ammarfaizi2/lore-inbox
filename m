Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265833AbUFIXUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbUFIXUX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 19:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265957AbUFIXUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 19:20:23 -0400
Received: from mail.kroah.org ([65.200.24.183]:53148 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265833AbUFIXUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 19:20:20 -0400
Date: Wed, 9 Jun 2004 16:19:20 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Couple of sysfs patches
Message-ID: <20040609231920.GA9132@kroah.com>
References: <200406090221.24739.dtor_core@ameritech.net> <200406091732.28684.dtor_core@ameritech.net> <20040609224548.GA1393@kroah.com> <200406091754.23303.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406091754.23303.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 05:54:23PM -0500, Dmitry Torokhov wrote:
> On Wednesday 09 June 2004 05:45 pm, Greg KH wrote:
> > On Wed, Jun 09, 2004 at 05:32:28PM -0500, Dmitry Torokhov wrote:
> > > Actually, I myself want someting else -
> > > 
> > > int platform_device_register_simple(struct platform_device **ppdev,
> > > 				    const char *name, int id)
> > > 
> > > It will allocate platform device, set name and id and release function to
> > > platform_device_simple_release which in turn will be hidden from outside
> > > world. Since the function does allocation for user is should prevent the
> > > abuse you were concerned about.
> > 
> > Ok, that sounds good.  I'll take patches for that kind of interface.
> > 
> > But have the function return the pointer, like the class_simple
> > functions work.  Not the ** like you just specified.
> 
> I want to do both allocation + registration in one shot and I knowing
> the error code may be important to users.

That's fine to do.  Again, look at how the class_simple_create()
function works.  If an error happens, convert it to ERR_PTR() and return
that.  The caller can check it with IS_ERR() and friends.

> Why do you oppose having double pointers in interface?

It's messy, and with the ERR_PTR() macros, not needed :)

thanks,

greg k-h
