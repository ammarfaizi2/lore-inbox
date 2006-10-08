Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWJHOJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWJHOJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 10:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWJHOJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 10:09:27 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:7714 "EHLO
	asav10.insightbb.com") by vger.kernel.org with ESMTP
	id S1751189AbWJHOJ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 10:09:26 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FADqiKEWBToo2LA
From: Dmitry Torokhov <dtor@insightbb.com>
To: "Zephaniah E. Hull" <warp@aehallh.com>
Subject: Re: [linux-usb-devel] [PATCH] usb/hid: The HID Simple Driver Interface 0.3.2 (core)
Date: Sun, 8 Oct 2006 10:09:22 -0400
User-Agent: KMail/1.9.3
Cc: "raise.sail@gmail.com" <raise.sail@gmail.com>, greg <greg@kroah.com>,
       Randy Dunlap <rdunlap@xenotime.net>,
       LKML <linux-kernel@vger.kernel.org>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
References: <200609291624123283320@gmail.com> <45286B85.90402@gmail.com> <20061008124146.GA4710@aehallh.com>
In-Reply-To: <20061008124146.GA4710@aehallh.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610081009.23978.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 October 2006 08:41, Zephaniah E. Hull wrote:
> 0: If you keep all the ID identical, userspace may have the capabilities
> cached.  This may also cause problems, but if Dmitry or Greg calls that
> a userspace bug I'll believe them and find a workaround.

Yes, I'd consider it a bug. Tearing down and re-creating input device
generates proper hotplug notifications and userspace needs to respect
them as capabilities may change even if ids stay the same. For example
playing with atkbd's scroll attribute will regenerate an input device
with[out] scroll capabilities but its input_id structure will stay the
same.

... Or were you talking about ids as in inputX? These are ever increasing
as new devices get created and will never be reused (as long as atomic_t
doesn't wrap around ;) )
 
-- 
Dmitry
