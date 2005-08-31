Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbVHaIEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbVHaIEJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 04:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbVHaIEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 04:04:09 -0400
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:56732 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S932196AbVHaIEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 04:04:08 -0400
X-Originating-IP: [145.64.134.242]
From: "David =?UTF-8?Q?H=C3=A4rdeman?=" <david@2gen.com>
To: chrisw@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
In-Reply-To: <20050830215518.GX7991@shell0.pdx.osdl.net>
Subject: Re: LSM root_plug module questions
Date: Wed, 31 Aug 2005 10:04:04 +0200
Message-ID: <20050831.uZb.25678700@www.hardeman.nu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Mailer: AngleMail for eGroupWare (http://www.egroupware.org) v 1.0.0.007
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright (chrisw@osdl.org) wrote:
> * David Härdeman (david@2gen.com) wrote:
> > I'm currently playing around with the security/root_plug.c LSM module
> you'll have better luck on the lsm list

Thanks for the pointer

> > 1) What's the recommended way of telling that someone is logging in to
> > the computer (via ssh, virtual console, serial console, X, whatever)
> > with LSM? Look for open() on /dev/pts?
>
> logging in...this is really a userspace notion, so via PAM.  creating a
> new process or changing credentials of a new process are the types of
> things that lsm watches (and of course, opening of files).

Yes, I realized that by reading the include/linux/security.h comments
describing the security hooks. The question is rather if there is something
which all the different methods of logging in have in common that can be
caught with a LSM hook?

> > 2) root_plug currently scans the usb device tree looking for the
> > appropriate device each time it's needed. In the interest of making the
> > result of the lookup cached, it is possible for a module to register so
> > that it is notified when a usb device is added/removed?
>
> I don't think that can be done in a race free manner.  Perhaps get the
> device and check its state, but you'd have to ask usb folks.  ATM, it's
> only checked during exec of root process.

The reason that I wanted to do caching is that I want to add more checks
to the root_plug module. For instance, to deny all socket accept() and
connect() calls when the USB module is missing (to not break already
established connections but not allow any new ones, e.g. to lock out any
new SSH sessions).

I'm assuming that this could introduce the need for some kind of caching
of the results of the USB-device-present check as the number of checks
increase.

Regards,
David

