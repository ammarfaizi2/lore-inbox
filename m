Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUDSRYV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 13:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbUDSRYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 13:24:21 -0400
Received: from mtaw6.prodigy.net ([64.164.98.56]:36815 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S261605AbUDSRYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 13:24:16 -0400
Message-ID: <40840B7E.4080605@pacbell.net>
Date: Mon, 19 Apr 2004 10:25:18 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Duncan Sands <baldrick@free.fr>
CC: Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Frederic Detienne <fd@cisco.com>
Subject: Re: [linux-usb-devel] [PATCH 1/9] USB usbfs: take a reference to
 the usb device
References: <200404141229.26677.baldrick@free.fr> <200404172217.10994.baldrick@free.fr>
In-Reply-To: <200404172217.10994.baldrick@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heh ... I like this, getting rid of more of locks from usbcore.


Duncan Sands wrote:
>   In later steps we can
> (1) turn dev->serialize into a rwsem

That doesn't bother me (unlike some folk!) but I do
agree it should wait until the rest shakes out, and
until we can observe benefits.  Hardly any code paths
need complete mutual exclusion (writelock).


> (2) push the acquisition of dev->serialize down to the lower levels as they are fixed up.

Actually at least some of those lower levels are getting
fixed by pushing the lock acquisition up.

The reason usbfs needs to get involved in that stuff is
that it's going around the standard usb driver structure.
One of the other things that "usbfs2" should do is act a
lot more like a "normal" device driver, so it plays better
with more of the normal usbcore mechanisms.

- Dave


