Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbUDPP2g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 11:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbUDPP0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 11:26:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47328 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263558AbUDPPYu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 11:24:50 -0400
Date: Fri, 16 Apr 2004 16:24:48 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Greg KH <greg@kroah.com>
Cc: Maneesh Soni <maneesh@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040416152448.GF24997@parcelfarce.linux.theplanet.co.uk>
References: <20040413124037.GA21637@in.ibm.com> <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk> <20040415220232.GC23039@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040415220232.GC23039@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 03:02:32PM -0700, Greg KH wrote:
> No, we don't want that.  It's ok to have a dangling symlink in the fs if
> the device the link was pointing to is now gone.  All of the struct
> class_device stuff relies on the fact that a struct device can go away
> at any time, and nothing bad will happen (with the exception of a stale
> symlink.)
> 
> Yeah, it can cause a few odd looking trees when you unplug and replug a
> device a bunch of times, all the while grabbing a reference to the class
> device, but once everything is released by the user, it is cleaned up
> properly, with no harm done to anything.

Except that these "symlinks" are expected to follow the target upon
renames.  Which means that we either need a very messy scanning of
the entire tree on every rename (obviously not feasible) or we need
to store pointer to target and regenerate the path.  Which, in turn,
requires holding a reference.
