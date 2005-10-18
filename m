Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbVJRSwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVJRSwU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 14:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVJRSwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 14:52:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:4268 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751196AbVJRSwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 14:52:18 -0400
Subject: Re: usb: Patch for USBDEVFS_IOCTL from 32-bit programs
From: Arjan van de Ven <arjan@infradead.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051018114933.276781da.zaitcev@redhat.com>
References: <20051017181554.77d0d45d.zaitcev@redhat.com>
	 <20051018171333.GA29504@kroah.com>
	 <20051018114933.276781da.zaitcev@redhat.com>
Content-Type: text/plain
Date: Tue, 18 Oct 2005 20:51:55 +0200
Message-Id: <1129661516.2779.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-18 at 11:49 -0700, Pete Zaitcev wrote:

> 
> The problem here is that compat_ptr does NOT turn user data pointer
> into a kernel pointer. It's still a user pointer, only sized
> differently. So, when you do set_fs(KERNEL_DS), this pointer
> is invalid (miraclously, it does work on AMD64, so Dell's tests
> pass on their new Xeons).
> 
> So, you cannot simply to have a small shim. Instead, you have to allocate
> the buffer, do copy_from_user(), and then call the ioctl. But then,
> it would be a double-copy, when the ioctl allocates the buffer again.
> 
> I tweaked this in various ways, and the patch I posted looks like
> the cleanest solution. But please tell me if I miss something obvious.


there is one more option; allocate on the user stack space for a 64 bit
struct, then copy_in_user() the fields to that and then pass the new
pointer to the 64 bit struct to the ioctl.....

Not saying this is better or worse than what you did, it's just another
option.

