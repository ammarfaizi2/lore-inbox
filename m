Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932599AbWFCJnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbWFCJnf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 05:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWFCJnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 05:43:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64688 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932599AbWFCJne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 05:43:34 -0400
Date: Sat, 3 Jun 2006 02:43:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Schwab <schwab@suse.de>
Cc: mjt@tls.msk.ru, stefanr@s5r6.in-berlin.de, chrisw@sous-sol.org,
       scjody@modernduck.com, bcollins@ubuntu.com,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [stable] [PATCH] sbp2: fix check of return value of
 hpsb_allocate_and_register_addrspace
Message-Id: <20060603024305.dd0404d0.akpm@osdl.org>
In-Reply-To: <jemzcu7fgw.fsf@sykes.suse.de>
References: <tkrat.f195e45ae32b9c02@s5r6.in-berlin.de>
	<20060603013515.GV18769@moss.sous-sol.org>
	<44814A63.1080707@s5r6.in-berlin.de>
	<44815283.7080306@tls.msk.ru>
	<jemzcu7fgw.fsf@sykes.suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Jun 2006 11:31:27 +0200
Andreas Schwab <schwab@suse.de> wrote:

> Michael Tokarev <mjt@tls.msk.ru> writes:
> 
> > Stefan Richter wrote:
> >> Chris Wright wrote:
> >>> * Stefan Richter (stefanr@s5r6.in-berlin.de) wrote:
> >> ....
> >>>> +++ linux-2.6.17-rc5/drivers/ieee1394/sbp2.c    2006-06-03
> >>>> 01:54:23.000000000 +0200
> >>>> @@ -845,7 +845,7 @@ static struct scsi_id_instance_data *sbp
> >>>>             &sbp2_highlevel, ud->ne->host, &sbp2_ops,
> >>>>             sizeof(struct sbp2_status_block), sizeof(quadlet_t),
> >>>>             0x010000000000ULL, CSR1212_ALL_SPACE_END);
> >>>> -    if (!scsi_id->status_fifo_addr) {
> >>>> +    if (scsi_id->status_fifo_addr == ~0ULL) {
> >
> > Umm.  Can this ~0ULL constant be #define'd to something?
> > It's way too simple to mis-read it as NULL (or ~NULL whatever).
> 
> How about writing it as -1?
> 

That's preferable.

It doesn't actually cause a problem, but status_fifo_addr is defined as
u64, which is not `unsigned long long'.  On powerpc, for example, u64 is
implemented as unsigned long.  -1 just works.
