Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbVBDWLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVBDWLP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 17:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265343AbVBDWFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:05:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:37833 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264351AbVBDVv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 16:51:59 -0500
Date: Fri, 4 Feb 2005 13:51:35 -0800
From: Greg KH <greg@kroah.com>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Emily Ratliff <emilyr@us.ibm.com>,
       Tom Lendacky <toml@us.ibm.com>, tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/1] tpm: implement use of sysfs classes
Message-ID: <20050204215134.GA27433@kroah.com>
References: <Pine.LNX.4.58.0412211209410.14092@jo.austin.ibm.com> <Pine.LNX.4.58.0501121236180.2453@jo.austin.ibm.com> <Pine.LNX.4.58.0501181621200.2473@jo.austin.ibm.com> <Pine.LNX.4.58.0501181735110.13908@jo.austin.ibm.com> <Pine.LNX.4.58.0501281539340.6360@jo.austin.ibm.com> <Pine.LNX.4.58.0501311322380.9872@jo.austin.ibm.com> <Pine.LNX.4.58.0502031034290.18135@jo.austin.ibm.com> <Pine.LNX.4.58.0502041405230.22211@jo.austin.ibm.com> <20050204205226.GA26780@kroah.com> <1107553040.22140.30.camel@jo.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107553040.22140.30.camel@jo.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 03:37:20PM -0600, Kylene Hall wrote:
> On Fri, 2005-02-04 at 14:52, Greg KH wrote:
> > On Fri, Feb 04, 2005 at 02:12:50PM -0600, Kylene Hall wrote:
> > > +static struct class tpm_class = {
> > > +	.name = "tpm",
> > > +	.class_dev_attrs = tpm_attrs,
> > > +};
> > 
> > Where is your release function?  Did you see any warnings from the
> > kernel when you removed any of these class devices?  Why did you ignore
> > it?
> > 
> Sorry, I missed the warning message.  I have looked at some other
> instances for what I might need to put in that function and I'm
> stumped.  I didn't kmalloc my class_device structure so I don't need to
> kfree it.

How do you create the structure that contains the class device?  What
will happen if a user holds a reference to the class device and your
structure holding that class device goes away?

Ick, I think I agree more and more with Al Viro that exposing this kind
of stuff to developers was a big mistake...

Anyway, why not try using the class_simple interface instead?  If you do
that you don't have to worry (as much) in the reference counting logic.

thanks,

greg k-h
