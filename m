Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264949AbUF1NhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbUF1NhP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 09:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbUF1NhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 09:37:15 -0400
Received: from web81309.mail.yahoo.com ([206.190.37.84]:6061 "HELO
	web81309.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264949AbUF1NhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 09:37:14 -0400
Message-ID: <20040628133714.14671.qmail@web81309.mail.yahoo.com>
Date: Mon, 28 Jun 2004 06:37:14 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: RE: [PARCH] driver core: add driver_find to find a driver by name
To: Christoph Hellwig <hch@infradead.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sun, Jun 27, 2004 at 09:26:03PM -0500, Dmitry Torokhov wrote:
> > Hi,
> >
> > Here is a patch that adds driver_find() that allows to search for a
> driver
> > on a bus by it's name. The function is similar to device_find already
> present
> > in the tree. I need it for my serio sysfs patches where user can re-bind
> > serio port to an alternate driver by echoing driver's name to serio
> port's
> > driver attribute.
> 
> It looks like it's missing some refcounting, no?

Actually I think that kset_find_obj is the one that is missing
refcounting - device/driver can easily go away on return from
this function as well, no?

Anyway, usage in serio should be fine as the whole thing is
protected by serio_sem.

--
Dmitry
