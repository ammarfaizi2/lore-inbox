Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264228AbUF0Rfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264228AbUF0Rfz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 13:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbUF0Rfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 13:35:33 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:34492 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264212AbUF0Rdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 13:33:47 -0400
Subject: Re: PATCH: Further aacraid work
From: James Bottomley <James.Bottomley@steeleye.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Alan Cox <alan@redhat.com>, "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       Arjan van de Ven <arjanv@redhat.com>, Clay Haapala <chaapala@cisco.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040618203207.GK1863@holomorphy.com>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189FD2407B@otce2k03.adaptec.com>
	<20040617203842.GC8705@devserv.devel.redhat.com>
	<20040617204828.GC1495@holomorphy.com>
	<20040618150518.GB1863@holomorphy.com> 
	<20040618203207.GK1863@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 27 Jun 2004 12:33:19 -0500
Message-Id: <1088357603.10872.69.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 15:32, William Lee Irwin III wrote:
> On Fri, Jun 18, 2004 at 08:05:18AM -0700, William Lee Irwin III wrote:
> > Proper changelog this time, and comments, too. Adaptec et al, please
> > verify this resolves the issues you've been having.
> > Someone say _something_.
> 
> jejb's seeing such improved results that I don't believe we need to
> wait for Adaptec's ack to merge this.
> 
> akpm, please apply.

The patch is already in mainline, but here's my final set of statistics
on it.  I traced the effectiveness over a full day's operations on a
scsi build and test machine (I don't get uptime much over a day on these
machines since they're usually being rebooted to test new patches).

The machine is an 8-way p66 voyager with 256k of memory.

I did notice the mergers start off high (at around 50%) after first boot
and then decline.  The asymptote of the decline appears to be around 26%
which is still a respectable merge rate for a non-iommu machine.  I was
impressed to see that even at the end of the day I was still getting
multi-page merges (still up to 128 pages).

The instrumentation counts the total number of pages in merged segments
and the total number of segments through the machine.  The final figures
for the day were

Total pages merged:	192682
Total segments:		549497

So the amount of I/O through the system is 2.2-2.9GB or more than ten
times the machine's actual memory capacity (hopefully this puts me well
up into the usual operating region for physical page fragmentation).

James


