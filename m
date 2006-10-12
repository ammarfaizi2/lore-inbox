Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932679AbWJLQlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbWJLQlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 12:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbWJLQlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 12:41:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29613 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932679AbWJLQlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 12:41:22 -0400
Date: Thu, 12 Oct 2006 09:40:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@suse.cz>
Cc: Eric Sandeen <esandeen@redhat.com>, Badari Pulavarty <pbadari@us.ibm.com>,
       Eric Sandeen <sandeen@sandeen.net>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 ext3 panic.
Message-Id: <20061012094036.e1a3f9f1.akpm@osdl.org>
In-Reply-To: <20061012122820.GK9495@atrey.karlin.mff.cuni.cz>
References: <20061009225036.GC26728@redhat.com>
	<20061010141145.GM23622@atrey.karlin.mff.cuni.cz>
	<452C18A6.3070607@redhat.com>
	<1160519106.28299.4.camel@dyn9047017100.beaverton.ibm.com>
	<452C4C47.2000107@sandeen.net>
	<20061011103325.GC6865@atrey.karlin.mff.cuni.cz>
	<452CF523.5090708@sandeen.net>
	<20061011142205.GB24508@atrey.karlin.mff.cuni.cz>
	<1160589284.1447.19.camel@dyn9047017100.beaverton.ibm.com>
	<452DAA26.6080200@redhat.com>
	<20061012122820.GK9495@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 14:28:20 +0200
Jan Kara <jack@suse.cz> wrote:

> Where can we call
> journal_dirty_data() without PageLock?

block_write_full_page() will unlock the page, so ext3_writepage()
will run journal_dirty_data_fn() against an unlocked page.

I haven't looked into the exact details of the race, but it should
be addressable via jbd_lock_bh_state() or j_list_lock coverage.
