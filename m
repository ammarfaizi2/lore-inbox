Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264591AbUEDTEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264591AbUEDTEK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 15:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264592AbUEDTEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 15:04:10 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:60151 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264591AbUEDTEG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 15:04:06 -0400
Subject: Re: [CHECKER] Kernel panic when diWrite fails to get a page
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       JFS Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.stanford.edu>
In-Reply-To: <Pine.GSO.4.44.0404301638500.14945-100000@elaine24.Stanford.EDU>
References: <Pine.GSO.4.44.0404301638500.14945-100000@elaine24.Stanford.EDU>
Content-Type: text/plain
Message-Id: <1083697432.2206.156.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 04 May 2004 14:03:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-30 at 18:40, Junfeng Yang wrote:
> txCommit calls diWrite, which can fail (diWrite -> read_metapage ->
> read_cache_page).  txAbortCommit will be called in that case.  Kernel will
> panic in LogSyncRelease on assert(log) because the "lo"g fields for some
> metapages are NULL.  If we are going to kernel panic anyway, we should
> panic at the first place without doing all these works to abort a
> transcation.

This is fixed by killing txAbortCommit and calling txAbort instead. 
txAbort has logic to only call LogSyncRelease when mp->lsn is non-zero,
in which case mp->log should be valid.  The patch can be found in the
thread "Double txEnd calls causing the kernel to panic".

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

