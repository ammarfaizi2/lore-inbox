Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290798AbSBLGu2>; Tue, 12 Feb 2002 01:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290797AbSBLGuS>; Tue, 12 Feb 2002 01:50:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17931 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290798AbSBLGuE>;
	Tue, 12 Feb 2002 01:50:04 -0500
Message-ID: <3C68BB15.AF27E615@mandrakesoft.com>
Date: Tue, 12 Feb 2002 01:49:57 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcus Alanen <maalanen@ra.abo.fi>
CC: perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch] request_region / release_resource mixup
In-Reply-To: <Pine.LNX.4.33.0202091708230.1410-100000@tuxedo.abo.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Alanen wrote:
> 
> Hi, looking at region and resource handling I see that request_region
> allocates the struct resource with kmalloc() while request_resource
> takes it as a parameter. This means that release_region uses kfree()
> and release_resource doesn't.
> 
> There are some drivers which mix this up by doing a request_region /
> release_resource pair, instead of the proper request_region /
> release_region. This leads to a memory leak.
> 
> I've tried to fix this below. Comments? Output is from bk diff -u,
> not sure what the best command would've been.

Good patch, but a comment.  When you replace release_resource(res) with
release_region(), you should also look and see if you can eliminate the
temporary variable 'res' too.

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
