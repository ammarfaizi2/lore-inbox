Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWEAVdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWEAVdu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWEAVdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:33:50 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46783 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750944AbWEAVds convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:33:48 -0400
Date: Tue, 2 May 2006 07:33:26 +1000
From: Nathan Scott <nathans@sgi.com>
To: Zoltan Boszormenyi <zboszor@dunaweb.hu>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Bad page state in process 'nfsd' with xfs
Message-ID: <20060502073325.B1873249@wobbly.melbourne.sgi.com>
References: <4454D59C.7000501@dunaweb.hu> <20060501102440.A1864834@wobbly.melbourne.sgi.com> <4455C1D0.5060104@dunaweb.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
In-Reply-To: <4455C1D0.5060104@dunaweb.hu>; from zboszor@dunaweb.hu on Mon, May 01, 2006 at 10:07:44AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 10:07:44AM +0200, Zoltan Boszormenyi wrote:
> Hi,
> 
> Nathan Scott írta:
> > On Sun, Apr 30, 2006 at 05:19:56PM +0200, Zoltan Boszormenyi wrote:
> >   
> >> ...
> >> Or not. I had an FC3/x86-64 system until two days ago, now I have FC5/86-64.
> >>
> >> When FC3 was installed I chose to format the partitions to XFS and since 
> >> then
> >> I had Oopses regularly with or without VMWare modules.
> >>     
> >
> > What was the stack trace for your oops...?
> >
> > cheers.
> >   
> 
> I reported some Oopses for earlier kernels, they are here:

These aren't oopses.  They do look similar, but slightly
different to the other report - your page count there is
off with the pixies, but its not as clear that its a single
bit error - yours are more like 0xfffe0000.  Quite strange.
You also have the odd high-32-bits-mirrors-low-32-bits in
page flags, both with one bit set.

Not sure XFS can be causing this (we don't touch page count
for regular file pages, and only touch PageUptodate in flags
IIRC, like most/all filesystems).

Were you also using NFS, as in the other report?

cheers.

-- 
Nathan
