Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVAYI1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVAYI1l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 03:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVAYI1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 03:27:41 -0500
Received: from massena-4-82-67-197-146.fbx.proxad.net ([82.67.197.146]:33152
	"EHLO pbaldrick.hd.free.fr") by vger.kernel.org with ESMTP
	id S261598AbVAYI1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 03:27:38 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Enforce USB interface claims
Date: Tue, 25 Jan 2005 09:27:33 +0100
User-Agent: KMail/1.7.1
Cc: Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>
References: <20050123111258.GA29513@taniwha.stupidest.org> <20050125060555.GC2061@kroah.com>
In-Reply-To: <20050125060555.GC2061@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501250927.33971.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > -	/* if not yet claimed, claim it for the driver */
> > -	dev_warn(&ps->dev->dev, "usbfs: process %d (%s) did not claim interface %u before use\n",
> > -	       current->pid, current->comm, ifnum);
> > -	return claimintf(ps, ifnum);
> > +	return -EINVAL;
> >  }
> >  
> >  static int findintfep(struct usb_device *dev, unsigned int ep)
> 
> 
> Um, why?  I think this is there to help with "broken" userspace code
> that was written before we enforced the rules of "you must claim an
> interface before using it."  As such, I don't think we can apply this
> patch.

Unfortunately it also means that there is no pressure to fix the user-space
code.  How about having it say that the autoclaiming is deprecated, and will
be removed at some point?

Ciao,

Duncan.
