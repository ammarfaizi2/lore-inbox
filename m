Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937166AbWLDTuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937166AbWLDTuc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 14:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937349AbWLDTuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 14:50:32 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:23954 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937166AbWLDTu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 14:50:29 -0500
Message-ID: <45747BF6.9090502@oracle.com>
Date: Mon, 04 Dec 2006 11:50:14 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch] remove redundant iov segment check
References: <000401c717dc$bff0c5e0$2589030a@amr.corp.intel.com>
In-Reply-To: <000401c717dc$bff0c5e0$2589030a@amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Maybe we should create another internal generic_file_aio_read/write
> for in-core function? fs/read_write.c and fs/aio.c are not module-able
> and the check is already there.  For external module, we can do the
> check and then calls down to the internal one.

Maybe.  I'd rather see fewer moving parts here, not more.

> I hate to see iov is being walked multiple times ....

Indeed, hence the desire to walk it once and pass down a summary of the
results in an explicit struct.  The patch in this thread removes one
redundancy, but there are many.  I think I counted 6 iovec walks in some
path?  I can't remember which.  I'd rather tackle them all in one go.

- z
