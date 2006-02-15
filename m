Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWBOVfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWBOVfQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 16:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWBOVfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 16:35:16 -0500
Received: from accolon.hansenpartnership.com ([64.109.89.108]:15754 "EHLO
	accolon.hansenpartnership.com") by vger.kernel.org with ESMTP
	id S1751301AbWBOVfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 16:35:14 -0500
Subject: Re: [linux-usb-devel] Re: Linux 2.6.16-rc3
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <Pine.LNX.4.44L0.0602151103160.4598-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0602151103160.4598-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 13:58:11 -0600
Message-Id: <1140033491.2883.11.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-15 at 11:07 -0500, Alan Stern wrote:
> Could we perhaps make this safer and more general?
> 
> For instance, add to struct device a "pending puts" counter and a list
> header (both protected by a global spinlock), and have a kernel thread
> periodically check the list, doing put_device wherever needed.  How does
> that sound?

That's what I've been discussing with Jens elsewhere on this list.
However, I think what you're proposing is overly complex.  All we really
need is for a way of flagging a kobject (or kref) so the final put will
be in user context.  Then we can use storage within the kobject or
device (or something else) for the purpose.

James


