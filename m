Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268711AbUJPMLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268711AbUJPMLj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 08:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268713AbUJPMLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 08:11:39 -0400
Received: from holomorphy.com ([207.189.100.168]:9873 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268711AbUJPMLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 08:11:36 -0400
Date: Sat, 16 Oct 2004 05:05:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Joel Becker <jlbec@evilplan.org>
Cc: Avi Kivity <avi@exanet.com>, Yasushi Saito <ysaito@hpl.hp.com>,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org, suparna@in.ibm.com,
       Janet Morgan <janetmor@us.ibm.com>
Subject: Re: [PATCH 1/2]  aio: add vectored I/O support
Message-ID: <20041016120504.GV5607@holomorphy.com>
References: <416EDD19.3010200@hpl.hp.com> <20041016031301.GC17142@parcelfarce.linux.theplanet.co.uk> <4170AF35.7030806@exanet.com> <20041016053721.GD17142@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041016053721.GD17142@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 07:18:45AM +0200, Avi Kivity wrote:
>> It is a huge performance win, at least on the 2.4-based RHEL kernel. 
>> Large reads (~256K) using 4K iocbs are very slow on a large RAID, while 
>> after I coded a similar patch I got a substantial speedup.

On Sat, Oct 16, 2004 at 06:37:21AM +0100, Joel Becker wrote:
> 	I'd think we should fix the submission path instead.  Why create
> iovs _and_ iocbs when we only need to create one?  And even if we
> decided aio_readv() was still nice to keep, we'd want to fix this
> inefficiency in io_submit().

Disk I/O can vector across iocb's; however, network I/O requires
temporal ordering not imposed by sequential iocb submission, barring
unusual extensions to the semantics.


-- wli
