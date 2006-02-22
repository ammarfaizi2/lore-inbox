Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWBVWBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWBVWBA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWBVWA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:00:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26774 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750971AbWBVWA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:00:58 -0500
Subject: Re: question about possibility of data loss in Ext2/3 file system
From: Arjan van de Ven <arjan@infradead.org>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <4ae3c140602221356x15015171h5aa4a3d7bb6034e0@mail.gmail.com>
References: <4ae3c140602221356x15015171h5aa4a3d7bb6034e0@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 23:00:51 +0100
Message-Id: <1140645651.2979.79.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-22 at 16:56 -0500, Xin Zhao wrote:
> As far as I know, in Ext2/3 file system, data blocks to be flushed to
> disk are usually marked as dirty and wait for kernel thread to flush
> them lazily. So data blocks of a file could be flushed even after this
> file is closed.
> 
> Now consider this scenario: suppose data block 2,3 and 4 of file A are
> marked to be flushed out. At time T1, block 2 and 3 are flushed, and
> file A is closed. However, at time T2, system experiences power outage
> and failed to flushed block 4. Does that mean we will end up with
> getting a partially flushed file?  Is there any way to provide better
> guarantee on file integrity?

on ext3 in default mode it works a bit different

if you write a NEW file that is

then first the data gets written (within like 5 seconds, and not waiting
for the lazy flush daemon). Only when that is done is the metadata (eg
filesize on disk) updated. So after the power comes back you don't see a
mixed thing; you see a file of a certain size, and all the data upto
that size is there.

If you need more guarantees you need to use fsync/fdata_sync from the
application.


