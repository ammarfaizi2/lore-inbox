Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbVBJSJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVBJSJM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 13:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVBJSJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 13:09:07 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:28483 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262182AbVBJSIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 13:08:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=PPQFZovJey0xutO/75Xse5yQ7Bf84lNjEYhKBAiuoim93U22TMoFFZEFd2OTr0mndTAgiUqbal97YZE5mTS4aFdTK8/H6wxove4cM86tRQ4jTztx0QsyJ8JvyQ6zHUUvwe/FEZI0HLBhWUeqKFpwlaMSGiPwznAdJzIMKjHfJ5o=
Message-ID: <d120d50005021010084a15460d@mail.gmail.com>
Date: Thu, 10 Feb 2005 13:08:18 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Adam Belay <abelay@novell.com>
Subject: Re: [RFC][PATCH] add driver matching priorities
Cc: Greg KH <greg@kroah.com>, rml@novell.com, linux-kernel@vger.kernel.org
In-Reply-To: <1108055918.3423.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1106951404.29709.20.camel@localhost.localdomain>
	 <20050210084113.GZ32727@kroah.com>
	 <1108055918.3423.23.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2005 12:18:37 -0500, Adam Belay <abelay@novell.com> wrote:
> On Thu, 2005-02-10 at 00:41 -0800, Greg KH wrote:
> > On Fri, Jan 28, 2005 at 05:30:04PM -0500, Adam Belay wrote:
> > > Hi,
> > >
> > > This patch adds initial support for driver matching priorities to the
> > > driver model.  It is needed for my work on converting the pci bridge
> > > driver to use "struct device_driver".  It may also be helpful for driver
> > > with more complex (or long id lists as I've seen in many cases) matching
> > > criteria.
> > >
> > > "match" has been added to "struct device_driver".  There are now two
> > > steps in the matching process.  The first step is a bus specific filter
> > > that determines possible driver candidates.  The second step is a driver
> > > specific match function that verifies if the driver will work with the
> > > hardware, and returns a priority code (how well it is able to handle the
> > > device).  The bus layer could override the driver's match function if
> > > necessary (similar to how it passes *probe through it's layer and then
> > > on to the actual driver).
> > >
> > > The current priorities are as follows:
> > >
> > > enum {
> > >     MATCH_PRIORITY_FAILURE = 0,
> > >     MATCH_PRIORITY_GENERIC,
> > >     MATCH_PRIORITY_NORMAL,
> > >     MATCH_PRIORITY_VENDOR,
> > > };
> > >
> > > let me know if any of this would need to be changed.  For example, the
> > > "struct bus_type" match function could return a priority code.
> > >
> > > Of course this patch is not going to be effective alone.  We also need
> > > to change the init order.  If a driver is registered early but isn't the
> > > best available, it will be bound to the device prematurely.  This would
> > > be a problem for carbus (yenta) bridges.
> > >
> > > I think we may have to load all in kernel drivers first, and then begin
> > > matching them to hardware.  Do you agree?  If so, I'd be happy to make a
> > > patch for that too.
> >
> > I think the issue that Al raises about drivers grabbing devices, and
> > then trying to unbind them might be a real problem.
> 
> I agree.  Do you think registering every in-kernel driver before probing
> hardware would solve this problem?

And what do you do with drivers that are built as modules?

-- 
Dmitry
