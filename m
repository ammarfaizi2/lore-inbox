Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVASCb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVASCb4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 21:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVASCb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 21:31:56 -0500
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:33733 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S261297AbVASCby
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 21:31:54 -0500
Date: Wed, 19 Jan 2005 04:31:51 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH - 2.6.10] generic_file_buffered_write handle partial DIO writes with multiple iovecs
Message-ID: <20050119023151.GK6725@m.safari.iki.fi>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1106097764.3041.16.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106097764.3041.16.camel@ibm-c.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 05:22:44PM -0800, Daniel McNeil wrote:
> Andrew,
> 
> This is a patch to generic_file_buffered_write() to correctly
> handle partial O_DIRECT writes (because of unallocated blocks)
> when there is more than 1 iovec.  Without this patch, the code is
> writing the wrong iovec (it writes the first iovec a 2nd time).
> 
> Included is a test program dio_bug.c that shows the problem by:
> 	writing 4k to offset 4k
> 	writing 4k to offset 12k
> 	writing 8k to offset 4k
> The result is that 8k write writes the 1st 4k of the buffer twice.
> 
> $ rm f; ./dio_bug f
> wrong value offset 8k expected 0x33 got 0x11
> wrong value offset 10k expected 0x44 got 0x22
> 
> with patch
> $ rm f; ./dio_bug f

I have Linux 2.6.10-ac9 + bio clone memory corruption -patch,
and dio_bug does not give errors (without your patch).

-- 
