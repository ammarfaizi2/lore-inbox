Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263236AbVFXKk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263236AbVFXKk7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 06:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbVFXKk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 06:40:59 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:37047 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263237AbVFXKk3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 06:40:29 -0400
Date: Fri, 24 Jun 2005 16:19:28 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org
Cc: linux-kernel@vger.kernel.org, bcrl@kvack.org, wli@holomorphy.com,
       zab@zabbo.net, mason@suse.com
Subject: [PATCH 0/2] Buffered filesystem AIO read/write
Message-ID: <20050624104928.GA4408@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050620120154.GA4810@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050620120154.GA4810@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 05:31:54PM +0530, Suparna Bhattacharya wrote:
> Since AIO development is gaining momentum once again, ocfs2 and
> samba both appear to be using AIO, NFS needs async semaphores etc,
> there appears to be an increase in interest in straightening out some
> of the pending work in this area. So this seems like a good
> time to re-post some of those patches for discussion and decision.
> 
> Just to help sync up, here is an initial list based on the pieces
> that have been in progress with patches in existence (please feel free
> to add/update ones I missed or reflected inaccurately here):
> 
> (1) Updating AIO to use wait-bit based filtered wakeups (me/wli)
> 	Status: Updated to 2.6.12-rc6, needs review
> (2) Buffered filesystem AIO read/write (me/Ben)
> 	Status: aio write: Updated to 2.6.12-rc6, needs review
> 	Status: aio read : Needs rework against readahead changes in mainline
> ...
> ...
> On my part, I'll start by re-posting (1) for discussion, and then
> move to (2).
>

Feedback on (1) seems positive so far, so now moving to (2), here are
the patches that implement the changes to make filesystem AIO read
and write truly asynchronous even without O_DIRECT. With these patches
in place it will no longer be necessary for the POSIX AIO library
(from Sébastien et al) to force O_DIRECT and memcpy for alignment.
(Samba should find this useful)

There are 2 patches: one for buffered filesystem AIO read and the other
for buffered filesystem AIO O_SYNC write. These build on the AIO wait bit
integration patches posted earlier.

Comments would be appreciated.

The full patchset including (1) and (2) above is available at
www.kernel.org/pub/linux/kernel/people/suparna/aio/2612

Regards
Suparna
-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

