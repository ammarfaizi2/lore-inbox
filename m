Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVAHXd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVAHXd5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 18:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVAHXd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 18:33:57 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:40344 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262080AbVAHXde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 18:33:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=gEortlBwDqwXkeYYXP707rC172asvUeFdTnHgoZaJ8j7mz+Uos/wdjn2/h/VITmV++laRTtz4odeYRg6tAoPk8VXOFYtE9DBr+CzFMLG/op9kE1Sim9NtHsR6Pe2ZYx0XFPcVI0nC4wJbsahu20iKfuHhERLHh6SGJ4lqE+W4w8=
Message-ID: <5a4c581d05010815336e826146@mail.gmail.com>
Date: Sun, 9 Jan 2005 00:33:33 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050108224232.GA3588@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <11051632633234@kroah.com> <11051632632994@kroah.com>
	 <20050108120858.GB27414@infradead.org>
	 <20050108224232.GA3588@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jan 2005 14:42:32 -0800, Greg KH <greg@kroah.com> wrote:
> On Sat, Jan 08, 2005 at 12:08:58PM +0000, Christoph Hellwig wrote:
> > On Fri, Jan 07, 2005 at 09:47:43PM -0800, Greg KH wrote:
> > > ChangeSet 1.1938.444.33, 2004/12/22 13:50:21-08:00, davej@redhat.com
> > >
> > > [PATCH] driver core: Fix up vesafb failure probing.
> > >
> > > bus.c file invokes a probe callback for most devices in a list, then checks
> > > for -ENODEV return ("no such device"), if so it remains silent. However, some
> > > drivers (including vesafb.c) may return -ENXIO ("no such device or address"),
> > > which is indeed error -6.
> > >
> > > I shut up the warning with the attached patch, that basically ignores
> > > both -ENODEV and -ENXIO.
> >
> > NAK.  We shouldn't have two return codes indicating the same error (or
> > actually non-error in this case).  Let's fix the drivers instead.
> 
> Ok, David, care to send a patch to do so?

The above would be the patch I posted here

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=125890

 the reason I went for the lazy approach is mainly that I tried to look into the
 usage of -ENXIO vs -ENODEV, but just grepping in drivers/video/*.c turned out
 to be confusing rather than enlightening... should *all* -ENXIO be converted
 into -ENODEV ?
