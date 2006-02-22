Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWBVUBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWBVUBK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWBVUBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:01:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8622 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750831AbWBVUBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:01:08 -0500
Date: Wed, 22 Feb 2006 12:00:47 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       stuart_hayes@dell.com, zaitcev@redhat.com
Subject: Re: Suppressing softrepeat
Message-Id: <20060222120047.4fd9051e.zaitcev@redhat.com>
In-Reply-To: <20060221210800.GA12102@suse.cz>
References: <20060221124308.5efd4889.zaitcev@redhat.com>
	<20060221210800.GA12102@suse.cz>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.12; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2006 22:08:00 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:

> A much simpler workaround for the DRAC3 is to set the softrepeat delay
> to at least 750ms, using kbdrate(8), which will call the proper console
> ioctl, resulting in updating the softrepeat parameters.
> 
> I prefer workarounds for problematic hardware done outside the kernel,
> if possible.

I agree with the sentiment when posed in the abstract way, but let me
tell you why this case is different.

Firstly, there's nothing "problematic" about this. It's just how it is.
The only problematic thing here is our code. Currently, the situation is
assymetric. It is possible to force softrepeat on, but not possible to
force softrepeat off. Isn't it broken?

Secondly, 750ms may be not enough. Stuart is being shy here and posting
explanations to Bugzilla for some reason.

Lastly, it's such a PITA to add these things into the userland, that
it's completely impractical. Console is needed the most when things go
wrong. In such case, that echo(1) may not be reached before the single
user shell. And stuffing it into the initrd is for Linux weenies only,
unless automated by mkinitrd.

I think you're being unreasonable here. I am not asking for NFS root
or IP autoconfiguration and sort of complicated process which ought to
be done in userland indeed.

-- Pete
