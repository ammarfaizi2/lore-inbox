Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbVAUQpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbVAUQpc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 11:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVAUQpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 11:45:32 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:46011 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262338AbVAUQno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 11:43:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=uAcupaSqXGRgR0xKpHz0gLv8rq7F4gf3OaGTdvrcnA/3mcFKXXJHrVTj5KZLx0N6d6/emVUw4ujeCw6waoGRqYB0/4AgqRierQ9tLW8xJrA1Hls9hBhL8T641MV3iNPxzfKucrLISSOCN7V+QPbgohH7CsLp9w25mxcI8mUP9WE=
Message-ID: <d120d50005012108434097267c@mail.gmail.com>
Date: Fri, 21 Jan 2005 11:43:44 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH][RFC]: Clean up resource allocation in i8042 driver
Cc: Prarit Bhargava <prarit@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050121163540.GC4795@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41F11C66.5000707@sgi.com>
	 <d120d500050121074313788f99@mail.gmail.com>
	 <20050121163540.GC4795@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2005 17:35:40 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Fri, Jan 21, 2005 at 10:43:36AM -0500, Dmitry Torokhov wrote:
> > Hi,
> >
> > On Fri, 21 Jan 2005 10:14:46 -0500, Prarit Bhargava <prarit@sgi.com> wrote:
> > > Hi,
> > >
> > > The following patch cleans up resource allocations in the i8042 driver
> > > when initialization fails.
> > >
> > ...
> > >
> > >                if (i8042_command(&param, I8042_CMD_CTL_TEST)) {
> > > -                       printk(KERN_ERR "i8042.c: i8042 controller self test timeout.\n");
> > > +                       if (i8042_read_status() != 0xFF)
> > > +                               printk(KERN_ERR "i8042.c: i8042 controller self test timeout.\n");
> > > +                       else
> > > +                               printk(KERN_ERR "i8042.c: no i8042 controller found.\n");
> >
> > Is this documented somewhere?
> 
> No. But vacant ports usually return 0xff. The problem here is that 0xff
> is a valid value for the status register, too. Fortunately this patch
> checks for 0xff only after the timeout failed.
> 
> Anyway, I suppose we could fail silently here on ia64 machines where
> ACPI is present.

But it ACPI is present but neither KBD nor PS mouse port is defined in
DSDT (or they not active as far as _STR goes) i8042_plantorm_init will
fail and we won't even get there...

-- 
Dmitry
