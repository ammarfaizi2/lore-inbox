Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266468AbUBES0X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 13:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266497AbUBES0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 13:26:23 -0500
Received: from mail.kroah.org ([65.200.24.183]:20193 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266468AbUBES0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 13:26:20 -0500
Date: Thu, 5 Feb 2004 10:26:14 -0800
From: Greg KH <greg@kroah.com>
To: Robert Gadsdon <robert@gadsdon.giointernet.co.uk>, bcollins@debian.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat"
Message-ID: <20040205182614.GG13075@kroah.com>
References: <fa.h1qu7q8.n6mopi@ifi.uio.no> <402240F9.3050607@gadsdon.giointernet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402240F9.3050607@gadsdon.giointernet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 01:11:21PM +0000, Robert Gadsdon wrote:
> 2.6.2-mm1 tombstone "Badness in kobject_get....." when booting:

Oooh, not nice.  That means a kobject is being used before it has been
initialized.  Glad to see that check finally helps out...

> ieee1394: Host added: ID:BUS[0-00:1023]  GUID[090050c50000046f]
> Badness in kobject_get at lib/kobject.c:431
> Call Trace:
>  [<c0239966>] kobject_get+0x36/0x40
>  [<c027cc73>] get_device+0x13/0x20
>  [<c027d899>] bus_for_each_dev+0x59/0xc0
>  [<d0939355>] nodemgr_node_probe+0x55/0x120 [ieee1394]
>  [<d0939200>] nodemgr_probe_ne_cb+0x0/0x90 [ieee1394]
>  [<d0939748>] nodemgr_host_thread+0x168/0x190 [ieee1394]
>  [<d09395e0>] nodemgr_host_thread+0x0/0x190 [ieee1394]
>  [<c010ac15>] kernel_thread_helper+0x5/0x10

Looks like one of the ieee1394 patches causes this.  Ben?

thanks,

greg k-h
