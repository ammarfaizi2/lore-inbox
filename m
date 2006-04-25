Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751621AbWDYVjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbWDYVjE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 17:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbWDYVjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 17:39:04 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:11699 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751621AbWDYVjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 17:39:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole;
        b=ijZ6SMO2T/mwaXTI2wt6OfcVIYVXL2Cz7QHF9Au2LXJYvQAPHjrLOxytuxpARKhvbKYyMJAxJI/lNN4Cttdpz1yDOyLL2m5MVEg18Ke8VSz8BuZATFhTeurt6LNT2OHnjG/pi5AHD6ZH7Ykvav9SwsC2INlYyOaJDFsntjHV3zo=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Jens Axboe'" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: RE: [PATCH] likely cleanup: revert unlikely in ll_back_merge_fn
Date: Tue, 25 Apr 2006 14:38:58 -0700
Message-ID: <004d01c668b0$a9c79540$853d010a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20060425183026.GR4102@suse.de>
Thread-Index: AcZoljkoV+BecDHHQHWxqMKfjRq2iAAGb7ng
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that new BIOs do not have BIO_SEG_VALID set. So when you do sequential IO, the IO being back-merged should always have not
had valid segments.

I ran bonnie++ and it shows the same thing.

> Well you'd want to optimize for the busy case, right, no 
> point in optimizing for a more idle system.
> 
> I'm not at all uninterested in this, I'd just like to see a 
> more intelligent/controlled work load that actually stresses 
> the io subsystem being profiled. If you have a not-so-busy 
> system, you like don't do enough IO to trigger a lot of 
> merges. Or maybe you do, and we just have a bug somewhere so 
> that we unfortunately repeatedly recount segments.
> 
> Care to run a simple io benchmark and profile that?
> 
> --
> Jens Axboe
> 

