Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVGYQaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVGYQaq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 12:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVGYQaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 12:30:46 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:32107 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261353AbVGYQao convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 12:30:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pDB2275r86nE7ybjm4UvcYQB5RpprM8xVLyMAcWXONVL4Ra/a+WOQCd+yjupVlr9bXSnQ3BqqpKuUuBRIbXp+SuXRKVO0H//+IuWFmIp30o4gkJhCRaqrA5IQbHX7bQU9+LDNFHO0LD8XjWn5AM+Ve2JvyHU9gcqJIsDq4+PNg8=
Message-ID: <9e47339105072509307386818b@mail.gmail.com>
Date: Mon, 25 Jul 2005 12:30:43 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: dtor_core@ameritech.net
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
In-Reply-To: <d120d5000507250748136a1e71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e47339105072421095af5d37a@mail.gmail.com>
	 <200507242358.12597.dtor_core@ameritech.net>
	 <9e4733910507250728a7882d4@mail.gmail.com>
	 <d120d5000507250748136a1e71@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/05, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 7/25/05, Jon Smirl <jonsmirl@gmail.com> wrote:
> > On 7/25/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > On Sunday 24 July 2005 23:09, Jon Smirl wrote:
> > > > I just pulled from GIT to test bind/unbind. I couldn't get it to work;
> > > > it isn't taking into account the CR on the end of the input value of
> > > > the sysfs attribute.  This patch will fix it but I'm sure there is a
> > > > cleaner solution.
> > > >
> > >
> > > "echo -n" should take care of this problem I think.
> >
> > That will work around it but I think we should fix it.  Changing to
> > strncmp() fixes most cases.
> >
> > -       if (strcmp(name, dev->bus_id) == 0)
> > +       if (strncmp(name, dev->bus_id, strlen(dev->bus_id)) == 0)
> >
> 
> This will produce "interesting results" if you have both "blah-1" and
> "blah-10" devices on the bus.

Then the better solution is to fix the generic attribute set code to
strip leading and trailing white space.

-- 
Jon Smirl
jonsmirl@gmail.com
