Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWFIX0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWFIX0s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 19:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWFIX0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 19:26:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30876 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932308AbWFIX0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 19:26:47 -0400
Date: Fri, 9 Jun 2006 16:26:34 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Heiko Gerstung <heiko.gerstung@meinberg.de>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Backport of a 2.6.x USB driver to 2.4.32 - help needed
Message-Id: <20060609162634.b98fde7c.zaitcev@redhat.com>
In-Reply-To: <mailman.1149588721.11795.linux-kernel2news@redhat.com>
References: <mailman.1149588721.11795.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jun 2006 11:48:36 +0200, Heiko Gerstung <heiko.gerstung@meinberg.de> wrote:

> [...] The maintainer of the driver
> modified a few things for me in order to address this problem ("it
> happens because get/set_registers() are called with no process
> context"), but he was only able to modify the 2.6.x driver for me.

> I started to backport the modified version, but it seems that I ran into
> dependency hell because I get the following two missing functions
> reported when I try to compile the backported module:
> 
> rtl8150.c: In Funktion »rtl8150_get_settings«:
> rtl8150.c:790: Warnung: implicit declaration of function `in_atomic'
> rtl8150.c: In Funktion »rtl8150_thread«:
> rtl8150.c:857: Warnung: implicit declaration of function
> `schedule_timeout_uninterruptible'

Tell the author to do it differently. Drivers have no business
to call in_atomic(). So, he postpones some accesses until later.
This is an easy way out, I did it myself in 2.4's usb-serial,
but it's wrong. I don't see what his excuse is. Mine was that
I didn't want to debug a freaking gazillion of usb-storage
subdrivers.

Who's the guy, anyway? Was it Petkan? I'm sure he'll listen
to reason, I worked with him before.

I'm going to keep an eye on rtl8150 and oppose in_atomic when
it sneaks in.

-- Pete
