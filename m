Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTLULg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 06:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbTLULg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 06:36:56 -0500
Received: from mail.shareable.org ([81.29.64.88]:41351 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262758AbTLULgz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 06:36:55 -0500
Date: Sun, 21 Dec 2003 11:36:40 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
Message-ID: <20031221113640.GF3438@mail.shareable.org>
References: <3FE492EF.2090202@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE492EF.2090202@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> What about switching to rcu?

What about killing fasync_helper altogether and using the method that
epoll uses to register "listeners" which send a signal when the poll
state of a device changes?

That would trim off code all over the place, make the fast paths a
little bit faster (in the case that there aren't any listeners), and
most importantly make SIGIO reliable for every kind of file descriptor,
instead of the pot luck you get now.

Just an idea :)

-- Jamie
