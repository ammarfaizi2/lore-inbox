Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbTFKQ7G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 12:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTFKQ7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 12:59:06 -0400
Received: from ida.rowland.org ([192.131.102.52]:5124 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262984AbTFKQ7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 12:59:05 -0400
Date: Wed, 11 Jun 2003 13:12:47 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: BUG in driver model class.c
Message-ID: <Pine.LNX.4.44L0.0306111305300.668-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg:

There is a bug in drivers/base/class.c in 2.5.70.  Near the start of the
routine class_device_add() are the lines

        if (class_dev->dev)
                get_device(class_dev->dev);

But there's nothing to undo this get_device, either in the error return 
part of class_device_add() or in class_device_del().

I assume that either this get_device() doesn't belong there or else there
should be corresponding put_device() calls in the other two spots.  
Whichever is the case, it should be easy for you to fix.

Alan Stern

