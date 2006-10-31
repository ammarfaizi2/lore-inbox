Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422963AbWJaINQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422963AbWJaINQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422823AbWJaINQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:13:16 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:23775 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1422963AbWJaINO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:13:14 -0500
Date: Tue, 31 Oct 2006 17:12:39 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Jun Sun <jsun@junsun.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reserve memory in low physical address - possible?
Message-ID: <20061031081239.GA9539@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Jun Sun <jsun@junsun.net>, linux-kernel@vger.kernel.org
References: <20061031072203.GA10744@srv.junsun.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061031072203.GA10744@srv.junsun.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 11:22:03PM -0800, Jun Sun wrote:
> I understand it is possible to reserve some memory at the end by
> specifying "mem=xxxM" option in kernel command line.  I looked into
> "memmap=xxxM" option but it appears not helpful for what I want.
> 
memmap takes multiple arguments, including the start address for the
memory map. You could also bump min_low_pfn manually if memmap= isn't
suitable for you, something like:

	magic_space = PFN_UP(init_pg_tables_end);
	min_low_pfn = magic_space + magic_size;

(assuming magic_size is rounded up already), should work fine. Though
memmap= already takes care of most of this for you, could you explain why
it's unsuitable?
