Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751541AbWFVWBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbWFVWBA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 18:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbWFVWBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 18:01:00 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:12303 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751541AbWFVWBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 18:01:00 -0400
Date: Fri, 23 Jun 2006 00:00:57 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Is the x86-64 kernel size limit real?
Message-ID: <20060622220057.GB52945@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <20060622204627.GA47994@dspnet.fr.eu.org> <e7f2jq$r17$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7f2jq$r17$1@terminus.zytor.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 02:38:02PM -0700, H. Peter Anvin wrote:
> It turns out x86-64, unlike i386, does still have a hardcoded limit,
> but the limit in build.c is wrong:
> 
> kernel/head.S:
>         /* 40MB kernel mapping. The kernel code cannot be bigger than that.
>            When you change this change KERNEL_TEXT_SIZE in page.h too. */
>         /* (2^48-(2*1024*1024*1024)-((2^39)*511)-((2^30)*510)) = 0 */
> 
> So this should be replaced by KERNEL_TEXT_SIZE in page.h, or better,
> this should be done dynamically in x86-64 too.

Interesting.  KERNEL_TEXT_SIZE wouldn't work though, since that's the
decompressed size while the 4Mb limit is on the compressed size.  As a
datapoint, though, the uncompressed image is 15.7Mb, for a 4.5Mb
compressed image.

  OG.

