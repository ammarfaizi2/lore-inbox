Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVASPoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVASPoH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 10:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVASPoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 10:44:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42985 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261757AbVASPmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 10:42:25 -0500
Date: Wed, 19 Jan 2005 07:42:08 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: usbmon, usb core, ARM
Message-ID: <20050119074208.3bfa6458@localhost.localdomain>
In-Reply-To: <200501182214.25273.david-b@pacbell.net>
References: <20050118212033.26e1b6f0@localhost.localdomain>
	<200501182214.25273.david-b@pacbell.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2005 22:14:24 -0800, David Brownell <david-b@pacbell.net> wrote:

> > > Also, I don't like the idea of scattering knowledge all over the place
> > > that the root hub is always given address 1 ... 
> 
> which you didn't address yet.

Yes, I have to look why you do not like using the pipe. Relying on pipe makes
tests dependant on URB only. No references to bus or HCD, therefore no
extra refcounts or worries about oopses. Also, HC drivers zero out the
urb->dev in giveback sequence which is a royal pain when trying to identify
a root hub. I thought about adding an extra flag like URB_ROOT_HUB to split
this use from the abuse of URB_NO_TRANSFER_DMA_MAP, but pipe looks better
all around. If you look at it from the angle I did, it stands to reason
that excessive encapsulation only masks _why_ it was safer, e.g. if one sees
something like urb_is_root_hub(urb), one must look up the implementation
to know if it uses urb->dev or not. Relying on address 1 without any symbolic
constant is obviously a bad idea though, I'll fix that.

-- Pete
