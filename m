Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVD0BUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVD0BUL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 21:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbVD0BUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 21:20:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3261 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261881AbVD0BUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 21:20:04 -0400
Date: Tue, 26 Apr 2005 21:20:03 -0400
From: Dave Jones <davej@redhat.com>
To: Neil Horman <nhorman@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] add check to /proc/devices read routines
Message-ID: <20050427012003.GA31496@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Neil Horman <nhorman@redhat.com>, linux-kernel@vger.kernel.org
References: <20050427010827.GA2451@hmsendeavour.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427010827.GA2451@hmsendeavour.rdu.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 09:08:27PM -0400, Neil Horman wrote:
 > Patch to add check to get_chrdev_list and get_blkdev_list to prevent reads of
 > /proc/devices from spilling over the provided page if more than 4096 bytes of
 > string data are generated from all the registered character and block devices in
 > a system
 > 
 > Signed-off-by: Neil Horman <nhorman@redhat.com>
 > 
 > 
 >  fs/char_dev.c         |   13 ++++++++++++-
 >  fs/proc/proc_misc.c   |    2 +-
 >  include/linux/genhd.h |    2 +-
 >  3 files changed, 14 insertions(+), 3 deletions(-)

Missing changes to drivers/block/genhd.c perhaps ?
You changed the prototype of get_blkdev_list(), but not
the implementation, which still takes a single arg.

I've not looked at this code at all, but it smells like
something that perhaps needs converting to use seq_file() and friends ?

		Dave

