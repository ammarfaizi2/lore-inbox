Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbULVEWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbULVEWn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 23:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbULVEWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 23:22:43 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:41413 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261957AbULVEWj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 23:22:39 -0500
From: David Brownell <david-b@pacbell.net>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] USB: fix Scheduling while atomic warning when resuming.
Date: Tue, 21 Dec 2004 20:22:52 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>
References: <200412220103.iBM13wS0002158@hera.kernel.org> <41C8EE9A.9080707@pobox.com>
In-Reply-To: <41C8EE9A.9080707@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412212022.52316.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 December 2004 7:48 pm, Jeff Garzik wrote:
> If we are going for a minimalist -rc patch, why not drop the lock, 
> sleep, then reacquire the lock?

If that lock were dropped, what would prevent other tasks from
touching the hardware while it's sending RESUME signaling down
the bus, and thereby mucking up the resume sequence?

That 20+ msec is a protocol timer.  Normally we'd want khubd
to handle such things, and then resume all the child devices,
but that's not so readily done for root hubs or during calls
from the pm core code.

- Dave

