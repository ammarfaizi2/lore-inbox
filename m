Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbVAUVZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbVAUVZz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 16:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbVAUVYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:24:09 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:20664 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262510AbVAUVWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:22:22 -0500
Date: Fri, 21 Jan 2005 13:22:12 -0800
From: Brandon Corey <bcorey@engr.sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Pollable Semaphores
Message-ID: <20050121212212.GA453910@firefly.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to find out if there is a pollable semaphore equivalent on Linux.

The main idea of a "pollable semaphore", is a semaphore with a related
file descriptor.  The file descriptor can be used to select() when the
semaphore is acquirable.  This provides a convenient way for users to
implement code synchronization between threads, where multiple file
descriptors are already being selected against.

We have a pollable semaphore implementation on IRIX that provides this
functionality.  The API consists of a handful of calls for creation and
destruction of pollable semaphores, as well as a means to attach them
to a file descriptor.  Beyond that, from the users point of view, they're
just treated as any other file descriptor.

These calls are routed through a library and then passed off to a kernel
driver that handles the events.  If someone selects against a semaphore
when it's unaquirable, the driver sleeps on a synchronization variable.
When the semaphore is subsequently made aquirable, the driver will wake up
any waiters.  Multiple pollable semaphores mixed with other file
descriptors can be selected against, and a wakeup will occur when any of
the semaphores become acquirable.

Is anyone aware of any equivalent functionality?

Brandon
