Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267815AbUJRXi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267815AbUJRXi0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 19:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267818AbUJRXi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 19:38:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:37016 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267815AbUJRXiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 19:38:25 -0400
Date: Mon, 18 Oct 2004 16:42:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: sct@redhat.com, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/3] ext3 reservation allow turn off for specifed file
Message-Id: <20041018164218.70fb08d3.akpm@osdl.org>
In-Reply-To: <1098140129.9754.1064.camel@w-ming2.beaverton.ibm.com>
References: <1097846833.1968.88.camel@sisko.scot.redhat.com>
	<1097856114.4591.28.camel@localhost.localdomain>
	<1097858401.1968.148.camel@sisko.scot.redhat.com>
	<1097872144.4591.54.camel@localhost.localdomain>
	<1097878826.1968.162.camel@sisko.scot.redhat.com>
	<1097879695.4591.61.camel@localhost.localdomain>
	<1098140129.9754.1064.camel@w-ming2.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> Allow user shut down reservation-based allocation(using ioctl) on a specific file(e.g. for seeky random write).

Applications currently pass a seeky-access hint into the kernel via
posix_fadvise(POSIX_FADV_RANDOM).  It would be nice to hook into that
rather than adding an ext3-specific ioctl.  Maybe just peeking at
file->f_ra.ra_pages would suffice.

