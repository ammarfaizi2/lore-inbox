Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUF0U3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUF0U3z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 16:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbUF0U3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 16:29:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39107 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264265AbUF0U3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 16:29:52 -0400
Date: Sun, 27 Jun 2004 13:29:45 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, <arjanv@redhat.com>, <jgarzik@redhat.com>,
       <tburke@redhat.com>, <linux-kernel@vger.kernel.org>,
       <mdharm-usb@one-eyed-alien.net>, <david-b@pacbell.net>,
       <oliver@neukum.org>, zaitcev@redhat.com
Subject: Re: drivers/block/ub.c
Message-Id: <20040627132945.70350f2a@lembas.zaitcev.lan>
In-Reply-To: <Pine.LNX.4.44L0.0406271120520.10357-100000@netrider.rowland.org>
References: <20040627050201.GA24788@kroah.com>
	<Pine.LNX.4.44L0.0406271120520.10357-100000@netrider.rowland.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2004 11:23:10 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> wrote:

> + * -- use serial numbers to hook onto same hosts (same minor) after
> disconnect

It was a poor wording by me. It refers to the drift of naming due to
increments in usb_host_id. After a disconnect and reconnect, /dev/uba1
refers to the device, but /proc/partitions says "ubb".

To correct this, I have to set gendisk->fist_minor before calling
add_disk(), but in order to do that, a driver has to track devices
somehow. A serial number looks like an obvious candidate for a key.

-- Pete
