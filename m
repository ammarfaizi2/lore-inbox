Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265199AbUGISzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265199AbUGISzb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 14:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265349AbUGISza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 14:55:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:30179 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265199AbUGISz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 14:55:27 -0400
Date: Fri, 9 Jul 2004 11:54:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesse Stockall <stockall@magma.ca>
Cc: s.rivoir@gts.it, linux-kernel@vger.kernel.org,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: 2.6.7-mm7
Message-Id: <20040709115411.23d96699.akpm@osdl.org>
In-Reply-To: <1089373506.8067.7.camel@homer.blizzard.org>
References: <20040708235025.5f8436b7.akpm@osdl.org>
	<40EE5418.2040000@gts.it>
	<20040709024112.7ef44d1d.akpm@osdl.org>
	<40EE732C.5020404@gts.it>
	<1089373506.8067.7.camel@homer.blizzard.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Stockall <stockall@magma.ca> wrote:
>
>  + *
>  + * Unfortunately we have to use a separate wait queue, because we need
>  + * to make sure that a thread waiting for a writelock won't block other
>  + * threads from acquiring a readlock.
>    */
>   void usb_lock_all_devices(void)
>   {
>  -       down_write(&usb_all_devices_rwsem);
>  +       wait_event(usb_all_devices_wqh,
>  +                       down_write_trylock(&usb_all_devices_rwsem));

That's a bit unusual.  Could you (or Alan) please explain the reason for
this a little more?
