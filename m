Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268524AbUJPFh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268524AbUJPFh2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 01:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268525AbUJPFh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 01:37:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25800 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268524AbUJPFhZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 01:37:25 -0400
Date: Sat, 16 Oct 2004 06:37:21 +0100
From: Joel Becker <jlbec@evilplan.org>
To: Avi Kivity <avi@exanet.com>
Cc: Yasushi Saito <ysaito@hpl.hp.com>, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, suparna@in.ibm.com,
       Janet Morgan <janetmor@us.ibm.com>
Subject: Re: [PATCH 1/2]  aio: add vectored I/O support
Message-ID: <20041016053721.GD17142@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Avi Kivity <avi@exanet.com>, Yasushi Saito <ysaito@hpl.hp.com>,
	linux-aio@kvack.org, linux-kernel@vger.kernel.org,
	suparna@in.ibm.com, Janet Morgan <janetmor@us.ibm.com>
References: <416EDD19.3010200@hpl.hp.com> <20041016031301.GC17142@parcelfarce.linux.theplanet.co.uk> <4170AF35.7030806@exanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4170AF35.7030806@exanet.com>
User-Agent: Mutt/1.4.1i
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 07:18:45AM +0200, Avi Kivity wrote:
> It is a huge performance win, at least on the 2.4-based RHEL kernel. 
> Large reads (~256K) using 4K iocbs are very slow on a large RAID, while 
> after I coded a similar patch I got a substantial speedup.

	I'd think we should fix the submission path instead.  Why create
iovs _and_ iocbs when we only need to create one?  And even if we
decided aio_readv() was still nice to keep, we'd want to fix this
inefficiency in io_submit().

Joel

-- 

"Nothing is wrong with California that a rise in the ocean level
 wouldn't cure."
        - Ross MacDonald

			http://www.jlbec.org/
			jlbec@evilplan.org
