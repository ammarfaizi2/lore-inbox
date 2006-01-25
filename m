Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWAYWcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWAYWcy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 17:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWAYWcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 17:32:54 -0500
Received: from mx.pathscale.com ([64.160.42.68]:62091 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932185AbWAYWcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 17:32:53 -0500
Subject: Re: RFC: ipath ioctls and their replacements
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <1137631411.4757.218.camel@serpentine.pathscale.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Wed, 25 Jan 2006 14:32:41 -0800
Message-Id: <1138228361.15295.55.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been flailing away at the ioctls in our driver, with a good degree
of success.  However, one in particular is proving tricky:

>         Opening the /dev/ipath special file assigns an appropriate free
>         unit (chip) and port (context on a chip) to a user process.
>         Think of it as similar to /dev/ptmx for ttys, except there isn't
>         a devpts-like filesystem behind it.  Once a process has
>         opened /dev/ipath, it needs to find out which unit and port it
>         has opened, so that it can access other attributes in /sys.  To
>         do this, we provide a GETPORT ioctl.

I still don't see how to replace this with anything else without
performing unnatural acts.

We use struct file's private_data to keep a pointer to the device in
use, which works fine for ioctl.

However, if I'm coming into the kernel over a netlink socket, I have no
obvious way of going from my table of devices to the processes that have
each one open, and I see no evidence that any other device driver tries
to do anything like this either.

Short of keeping a reference to the task_struct in the device, or
walking the sending process's file table if we receive a netlink message
(both of which are disgusting), I see no way to make this ioctl go away.

Am I missing something?

	<b

