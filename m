Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVBSPHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVBSPHF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 10:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVBSPHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 10:07:04 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:9094 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261721AbVBSPHA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 10:07:00 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Jody McIntyre <scjody@modernduck.com>
Subject: Re: [PATCH] ohci1394: dma_pool_destroy while in_atomic() && irqs_disabled()
Date: Sat, 19 Feb 2005 10:06:20 -0500
User-Agent: KMail/1.7.92
Cc: Dan Dennedy <dan@dennedy.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>
References: <1108740772.4588.3.camel@kino.dennedy.org> <200502181042.47404.kernel-stuff@comcast.net> <20050219063632.GE9231@conscoop.ottawa.on.ca>
In-Reply-To: <20050219063632.GE9231@conscoop.ottawa.on.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502191006.21076.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 February 2005 01:36 am, Jody McIntyre wrote:
> I disagree because the impact of this bug is small.  How often do you start
> an ISO receive?  If you think it needs to be fixed urgently, please
> explain why - maybe I'm just missing somethnig.
>

I have to agree that the impact is small even for the people using ISO recv - 
I happen to use it quite frequently and it hasn't locked up on me yet. So I 
certainly don't need it fixed atm. It's just the "dmesg annoyance" if you 
will, to deal with :) !

> I'm not sure, but I looked through the code and it seems to allocate:
>  - 16 buffers of 2x PAGE_SIZE (= 131072 on i386)
>  - 16 buffers of PAGE_SIZE (= 65536 on i386)
>  - various other smaller structures.

OTOH, if it allocates so much of memory while irqs disabled and holding locks, 
isn't there a  good chance for the allocator to sleep and things to go wrong?

Parag 
