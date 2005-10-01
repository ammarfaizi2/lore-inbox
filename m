Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVJAA00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVJAA00 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 20:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbVJAA00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 20:26:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62395 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750700AbVJAA0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 20:26:25 -0400
Date: Fri, 30 Sep 2005 17:26:00 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Phil Dibowitz <phil@ipom.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       usb-storage@lists.one-eyed-alien.net, zaitcev@redhat.com
Subject: Re: RFC drivers/usb/storage/libusual
Message-Id: <20050930172600.298b7cac.zaitcev@redhat.com>
In-Reply-To: <433CE491.90305@ipom.com>
References: <20050927205559.078ba9ed.zaitcev@redhat.com>
	<433CE491.90305@ipom.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2005 00:09:05 -0700, Phil Dibowitz <phil@ipom.com> wrote:

> A quick look over the patch shows that there are now two kinds of
> unusual_dev entries: unusual_dev() and unusual_dev_fl(), where the
> latter is for entries that don't need to specify SC or PR (i.e., just
> had US_SC_DEVICE, US_PR_DEVICE in them). While I think that's a
> reasonable change, it's not clear to me why that's useful to the rest of
> the patch, or it's just making unusual_devs.h artificially shorter?

Greg asked that too and I skipped his question because I needed an
explanation. So here it is now.

I thought that the match list for USB core and the shadow list that
usb-storage had were separate. So, libusual receives the first but
not the second, which remains in usb-storage. Once they are split
like that, I thought it unsafe to continue to use an index to
correlate them, so I added extra fields into the list of information
specific list to usb-storage, for matching. These fields use more
memory, so I thought it would cost nothing to move flags over
into driver_info. The resultant savings make usb-storage somewhat
shorter than it was before. It is shorter even when libusual is
configured off. This is because the second list is about twice
shorter now.

I can drop that part of the patch, I just thought it would be safer.
If you prefer that, I would suggest moving "normal" devices at the
bottom of the list into the unusual_devs.h, to make sure that
indexes stay the same. In such case, we won't need dropping commas.

-- Pete
