Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbVHKU3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVHKU3s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 16:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbVHKU3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 16:29:47 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:52239 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932440AbVHKU3r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 16:29:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WcKbi6En5tVYJa0VvbWN/QKz7cYNAxg7tMOrXcxtUP/LwiiQMPEL6o3oFrp03CkjB64e+z5ys36PQKJVXCNRbJ1c02+D9/p0J+YkgIW2KvrYOYZ+FwbR7TKUplbTTB/XTfXordAeguDKGFEiDL3cbkc3qJMbVSW8iv62ChmYgI8=
Message-ID: <d120d50005081113294dbb4961@mail.gmail.com>
Date: Thu, 11 Aug 2005 15:29:46 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Don't use a klist for drivers' set-of-devices
Cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0508111540420.6745-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050811185332.GA6870@infradead.org>
	 <Pine.LNX.4.44L0.0508111540420.6745-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/05, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 11 Aug 2005, Christoph Hellwig wrote:
> 
> > On Thu, Aug 11, 2005 at 11:24:23AM -0700, Greg KH wrote:
> > > > This patch (as536) simplifies the driver-model core by replacing the klist
> > > > used to store the set of devices bound to a driver with a regular list
> > > > protected by a mutex.  It turns out that even with a klist, there are too
> > > > many opportunities for races for the list to be used safely by more than
> > > > one thread at a time.  And given that only one thread uses the list at any
> > > > moment, there's no need to add all the extra overhead of making it a
> > > > klist.
> > >
> > > Hm, but that was the whole reason to go to a klist in the first place.
> >
> > And shows once more that the klist approach was totally misguided.
> 
> I'll let Pat answer Christoph's comment.
> 
> Do note that the bus's list of devices and the bus's list of registered
> drivers are still klists.  Only the driver's list of bound devices gets
> reverted to a normal list.
>

Hmm, so what do I do in the following scenario - I have a serio port
(AUX) that has a synaptics touchpad bound to it which is driven by
psmouse driver. psmouse driver registers a child port (synaptics
pass-through) during probe call. The child port is also driven by
psmouse module - but it looks like it will deadlock when binding.

Am I missing something here?

-- 
Dmitry
