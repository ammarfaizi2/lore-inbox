Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbUFJTdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUFJTdO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 15:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUFJTdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 15:33:14 -0400
Received: from mail.kroah.org ([65.200.24.183]:57022 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262585AbUFJTdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 15:33:11 -0400
Date: Thu, 10 Jun 2004 12:32:08 -0700
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: sensors@stimpy.netroedge.com,
       "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finding user/kernel pointer bugs [no html]
Message-ID: <20040610193207.GA1904@kroah.com>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu> <20040610044903.GE12308@parcelfarce.linux.theplanet.co.uk> <20040610165821.GB32577@kroah.com> <20040610191004.GA1661@kroah.com> <20040610191359.GJ12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040610191359.GJ12308@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 08:14:00PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Thu, Jun 10, 2004 at 12:10:04PM -0700, Greg KH wrote:
> > @@ -170,8 +170,11 @@
> >  static int DIV_TO_REG(int val)
> >  {
> >  	int answer = 0;
> > -	while ((val >>= 1))
> > +	val >>= 1;
> > +	while (val) {
> >  		answer++;
> > +		val >>= 1;
> > +	}
> >  	return answer;
> 
> That's less readable than the original...

Hm, so we should ignore the sparse warning about the original then?

> > -		data_ptrs = (u8 **) kmalloc(rdwr_arg.nmsgs * sizeof(u8 *),
> > -					    GFP_KERNEL);
> > +		data_ptrs = kmalloc(rdwr_arg.nmsgs * sizeof(u8 __user *), GFP_KERNEL);
> 
> While we are at it, what's the type of ->nmsgs?

include/linux/i2c-dev.h states it is __u32.  Any problems with that?

thanks,

greg k-h
