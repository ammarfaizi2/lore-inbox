Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWEPB6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWEPB6E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 21:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWEPB6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 21:58:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28833 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751012AbWEPB6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 21:58:03 -0400
Date: Mon, 15 May 2006 18:54:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       reuben-lkml@reub.net
Subject: Re: [PATCH 001 of 3] md: Change md/bitmap file handling to use bmap
 to file blocks-fix
Message-Id: <20060515185440.0989a805.akpm@osdl.org>
In-Reply-To: <1060516011302.2711@suse.de>
References: <20060516111036.2649.patches@notabene>
	<1060516011302.2711@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown <neilb@suse.de> wrote:
>
>  +		do_sync_file_range(file, 0, LLONG_MAX,
>  +				   SYNC_FILE_RANGE_WRITE |
>  +				   SYNC_FILE_RANGE_WAIT_AFTER);

That needs a SYNC_FILE_RANGE_WAIT_BEFORE too.  Otherwise any dirty,
under-writeback pages will remain dirty.  I'll make that change.
