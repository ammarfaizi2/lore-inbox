Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbULKB3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbULKB3J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 20:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbULKB3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 20:29:09 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:21202 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261902AbULKB3G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 20:29:06 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [RFC PATCH] debugfs - yet another in-kernel file system
Date: Fri, 10 Dec 2004 17:29:01 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20041210005055.GA17822@kroah.com>
In-Reply-To: <20041210005055.GA17822@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200412101729.01155.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 December 2004 4:50 pm, Greg KH wrote:
> What if there was a in-kernel filesystem that was explicitly just for
> putting debugging stuff?  Some place other than proc and sysfs, and that
> was easier than both of them to use.  Yet it needed to also be able to
> handle complex stuff like seq file and raw file_ops if needed.

The problem with sysfs here is:  no seq_file support.
Otherwise it solves the basic "where to put the debug
files associated with "device X" or "driver Y" problems
in a good non-confusing way:  there are directories
already set up for devices and for drivers.

The problem with procfs here is that it doesn't have
such a naming solution:  there's no automatic mapping
betwen a /proc/driver/...file and its device, or vice
versa.  That issue is shared with debugfs.

Couldn't debugfs just be a thin shim on top of sysfs,
adding seq_file support?  Or on top of procfs, adding
device/driver naming domains, and maybe file-per-value
read/write support for drivers that want them?

What I'd really want out of a debug file API is to resolve
the naming issues, work with seq_file, and "softly and
silently vanish away".  I think this patch has the last
two, but not the first one!

- Dave
