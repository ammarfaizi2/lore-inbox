Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbTJ3FnU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 00:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbTJ3FnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 00:43:20 -0500
Received: from linux.us.dell.com ([143.166.224.162]:8625 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262130AbTJ3FnT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 00:43:19 -0500
Date: Wed, 29 Oct 2003 23:42:54 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Ref-count problem in kset_find_obj?
Message-ID: <20031029234254.A13162@lists.us.dell.com>
References: <20031029123820.GA1141@mschwid3.boeblingen.de.ibm.com> <Pine.LNX.4.44.0310291623420.1023-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0310291623420.1023-100000@cherise>; from mochel@osdl.org on Wed, Oct 29, 2003 at 04:24:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 29, 2003 at 04:24:58PM -0800, Patrick Mochel wrote:
> 
> > The reference count of the kobject to be returned is not
> > increased before the semaphore is released. A kobject_del/unlink
> > could remove the object before the called of kset_find_obj is
> > able to increase the reference count. This makes kset_find_obj
> > more or less unusable, doesn't it?
> 
> Yes, you're right. The function is pretty much unused, and I don't have a 
> problem removing it, provided we can fix up the one user 
> (arch/i386/kernel/edd.c). Unless of course, you're planning on using it..

At the moment, edd.c doesn't actually use it.  It wants to -
find_bus() is a useful concept, but I haven't proven that the scsi_bus
list only has scsi_devices on it, so that code isn't compiled in at
present.  If the scsi_bus list is clean now, then yes, I'll want to
turn it back on (after 2.6.0 is out) and will need find_bus() to be
possible.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
