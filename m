Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266560AbUFWVTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266560AbUFWVTY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbUFWVTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:19:22 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:10770 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S266701AbUFWVRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:17:20 -0400
Date: Wed, 23 Jun 2004 16:18:29 -0500
From: mikem@beardog.cca.cpqcorp.net
To: linux-kernel@vger.kernel.org
Cc: viro@www.linux.org.uk, bob.montgomery@hp.com
Subject: problems with alloc_disk in genhd.c
Message-ID: <20040623211829.GC16336@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We've encountered a problem using one of our internal test tools. It calls
our CCISS_GETLUNINFO ioctl for partition info. In the *alloc_disk(int minors)
function it only tests for the max_number_of_parts - 1.

        if (minors > 1) {
                int size = (minors - 1) * sizeof(struct hd_struct *);

When we allocate space we pass in

        for (n = 0; n < NWD; n++) {
                disk[n] = alloc_disk(1 << NWD_SHIFT);

In the  ioctl we are doing

        /* count partitions 1 to 15 with sizes > 0 */
        for(i=0; i <MAX_PART; i++) {


Depending on what lies beyond the array we have seen either Oops's or
a hard lock with a reboot about 30 seconds later. If we pass in MAX_PART - 1
we have no problems.
Is the entire disk no longer counted as partition zero?
Other drivers also pass in their max part value. Have any other problems
been reported?

Thanks,
mikem

