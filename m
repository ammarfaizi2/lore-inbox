Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266341AbUIVCHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbUIVCHV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 22:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267646AbUIVCHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 22:07:21 -0400
Received: from coriana6.CIS.McMaster.CA ([130.113.128.17]:6795 "EHLO
	coriana6.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S266341AbUIVCHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 22:07:18 -0400
Subject: Re: [RFC][PATCH] inotify 0.9.2
From: John McCutchan <ttb@tentacle.dhs.org>
To: Robert Love <rml@novell.com>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <1095792996.4944.59.camel@betsy.boston.ximian.com>
References: <1095652572.23128.2.camel@vertex>
	 <1095782674.4944.41.camel@betsy.boston.ximian.com>
	 <1095792996.4944.59.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095820345.22558.7.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 21 Sep 2004 22:32:25 -0400
X-PMX-Version-Mac: 4.7.0.111621, Antispam-Engine: 2.0.0.0, Antispam-Data: 2004.9.21.5
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-21 at 14:56, Robert Love wrote:
> On Tue, 2004-09-21 at 12:04 -0400, Robert Love wrote:
> 
> > Hey, John.
> > 
> > We are seeing an oops when monitoring a large number of directories.
> > The system keeps running, but I/O gets flaky and eventually processes
> > start getting stuck.
> > 
> > Also, the ioctl() stops returning new WD after 1024.  Thereafter, it
> > keeps returning the same value.
> > 
> > I have attached the relevant bits from the syslog.  I will debug it, but
> > I thought that perhaps you would immediately see the issue.
> 
> OK.  I fixed the problem with ioctl() failing after 1024 WD's.  This may
> also fix the oopses.  Still checking on that.
> 

I hope it fixes the oopses, I have only just started looking at the oops
you sent me, and nothing jumped out at me.

> The problem was that we were passing the size of dev->bitmask in _bytes_
> to find_first_zero_bit().  But find_first_zero_bit()'s second parameter
> is the size in _bits_.
>

Good to know, I wasn't sure when I wrote this code.

> I then went ahead and just made dev->bitmask an array, since we know the
> size at compile time.
> 
> Comments?

Sounds good.

John
