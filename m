Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbUBXK2Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 05:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbUBXK2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 05:28:24 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:9967 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262182AbUBXK2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 05:28:22 -0500
Date: Tue, 24 Feb 2004 21:33:41 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: akpm@osdl.org, linux-aio@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: Latest AIO patchset
Message-ID: <20040224160341.GA11739@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The latest set of AIO patches are being maintained at:
http://www.kernel.org/pub/linux/kernel/people/suparna/aio/

The patches have been reduced to a minimal set that addresses
the most relevant blocking points. Please let me know if you
think there is a case for bringing in any of the additional 
patches.
(The patches need to be applied in the order mention in the 
'series' file)

A new addition to the patchset is Chris Mason's nice and simple
implementation of AIO support for pipes using the retry 
infrastructure. He also fixed some problems in the AIO cancel
logic to make it play well with retries.

Besides this and some re-organization and cleaning up, there
are a couple of changes since the last set of patches in -mm, that
are worth a mention:

- Upfront readahead is now clipped to the readahead limit for
  the device (ra_pages) and happens only for AIO. This helps
  address the sendfile regression seen by Felix von Leitner.
  If your AIO read requests are likely to exceed the default 
  readahead size, then use hdparm -a <new size> to tune it.
  The patchset also currently includes Ram Pai's adaptive
  lazy readahead code which is required for good streaming AIO
  read performance.
- David Brownell's suggestion of enabling the fops to set up
  their own retry methods. This should make his USB gadgetfs
  AIO patch co-exist smoothly with fsaio.

Some basic results are up comparing streaming non-cached random 
AIO read/write throughputs for a single ext3 file using aio-stress 
for various io sizes with and without these patches, and also 
comparsions with O_DIRECT AIO throughputs. The short summary has
been a doubling of throughput using the fsaio patches, which is
also close to the results seen with O_DIRECT AIO.

As usual feedback, bug fixes, test results etc are welcome.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

