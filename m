Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266199AbUIED7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266199AbUIED7m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 23:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUIED7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 23:59:42 -0400
Received: from peabody.ximian.com ([130.57.169.10]:46555 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266199AbUIED72
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 23:59:28 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@ximian.com>
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, kay.sievers@vrfy.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040904005433.GA18229@kroah.com>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
	 <20040831145643.08fdf612.akpm@osdl.org>
	 <1093989513.4815.45.camel@betsy.boston.ximian.com>
	 <20040831150645.4aa8fd27.akpm@osdl.org>
	 <1093989924.4815.56.camel@betsy.boston.ximian.com>
	 <20040902083407.GC3191@kroah.com>
	 <1094142321.2284.12.camel@betsy.boston.ximian.com>
	 <20040904005433.GA18229@kroah.com>
Content-Type: text/plain
Date: Sat, 04 Sep 2004 23:59:24 -0400
Message-Id: <1094356764.2591.31.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-04 at 02:54 +0200, Greg KH wrote:

> But transports are important, I agree.

Oh, I have another thought (see my previous email first).

The proper course of action based on your suggestion is to cleanly
abstract the concept of the "backend transport" from the notifier, and
offer a compile-time option of hotplug, netlink, and/or whatever else.
Make the transport pluggable and configurable.  Do it cleanly.  Yada
yada.

But that is a lot of code and a lot of work.  More than I think is
warranted, right?

Accepting that the above is the clean and proper way to do what you say,
let's carry it through.  What is the ideal situation?  People pick
either hotplug or netlink or foo as their transport.  Why pick more than
one?  Most people select hotplug because that is there now and works.
Maybe in the future people would choose netlink and move to that.  This
is all ideally.

In practice, however, we get people enabling both hotplug and netlink,
because they need hotplug for hotplug and want netlink for the new
kevent stuff.  So this approach leads to no one ever picking the ideal.

What we want is people using hotplug for hotplug, and kevent over
netlink for the event stuff.

So why stick the two together?

We have kobject_hotplug() and kobject_notify() and everything makes
sense.

	Robert Love


