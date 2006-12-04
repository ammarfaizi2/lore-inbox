Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937055AbWLDQGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937055AbWLDQGq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937053AbWLDQGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:06:46 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:60391 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S937055AbWLDQGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:06:45 -0500
Date: Mon, 4 Dec 2006 11:06:41 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Maneesh Soni <maneesh@in.ibm.com>
cc: Oliver Neukum <oliver@neukum.org>, <gregkh@suse.com>,
       <linux-usb-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: race in sysfs between sysfs_remove_file() and read()/write() #2
In-Reply-To: <20061204130406.GA2314@in.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0612041101410.3606-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006, Maneesh Soni wrote:

> hmm, I guess Greg has to say the final word. The question is either to fail
> the IO (-ENODEV) or fail the file removal (-EBUSY). If we are not going to
> fail the removal then your patch is the way to go.
> 
> Greg?

Oliver is right that we cannot allow device_remove_file() to fail.  In 
fact we can't even allow it to block until all the existing open file 
references are closed.

Our major questions have to do with the details of the patch itself.  In 
particular, we are worried about possible races with the VFS and the 
handling of the inode's usage count.  Can you examine the patch carefully 
to see if it is okay?

Also, Oliver, it looks like the latest version of your patch makes an 
unnecessary change to sysfs_remove_file().

Alan Stern

