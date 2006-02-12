Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWBLK2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWBLK2k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 05:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWBLK2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 05:28:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28825 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932378AbWBLK2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 05:28:39 -0500
Date: Sun, 12 Feb 2006 02:27:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: kkeil@suse.de, i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       gregkh@suse.de, tilman@imap.cc
Subject: Re: [PATCH 6/9] isdn4linux: Siemens Gigaset drivers - procfs
 interface
Message-Id: <20060212022742.16df78a2.akpm@osdl.org>
In-Reply-To: <gigaset307x.2006.02.11.001.6@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.02.11.001.0@hjlipp.my-fqdn.de>
	<gigaset307x.2006.02.11.001.1@hjlipp.my-fqdn.de>
	<gigaset307x.2006.02.11.001.2@hjlipp.my-fqdn.de>
	<gigaset307x.2006.02.11.001.3@hjlipp.my-fqdn.de>
	<gigaset307x.2006.02.11.001.4@hjlipp.my-fqdn.de>
	<gigaset307x.2006.02.11.001.5@hjlipp.my-fqdn.de>
	<gigaset307x.2006.02.11.001.6@hjlipp.my-fqdn.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hansjoerg Lipp <hjlipp@web.de> wrote:
>
> This patch adds the procfs interface to the gigaset module.

sysfs, actually.

The patches look reasonable from a quick scan.  A few little things:

- The ringbuffer head and tail indexes are atomic_t's, but always seem to
  be manipulated inside the lock.  Perhaps they can become integers.

- You did the ringbuffer the wrong way.  Don't constrain the head and
  tail to be within 0..MAX_EVENTS.  Instead, just let them wrap right up to
  0xffffffff.   Apply the masking when you actually _use_ them.

  That way, empty is (head == tail) and full is (tail - head == MAX_EVENTS).

- Could use kstrdup() in a few places.

- A few unneeded casts of void*'s, but everyone does that.

- There are a lot of global symbols in there.  Perhaps they don't all
  need to be global.


