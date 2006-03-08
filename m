Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWCHQY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWCHQY4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 11:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030179AbWCHQY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 11:24:56 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:42678 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932331AbWCHQYz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 11:24:55 -0500
Subject: Re: [PATCH 2/3] Remove readv/writev methods and use
	aio_read/aio_write instead
From: Badari Pulavarty <pbadari@us.ibm.com>
To: christoph <hch@lst.de>
Cc: Zach Brown <zach.brown@oracle.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20060308124511.GB4128@lst.de>
References: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com>
	 <1141777382.17095.38.camel@dyn9047017100.beaverton.ibm.com>
	 <20060308124511.GB4128@lst.de>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 08:26:27 -0800
Message-Id: <1141835187.17095.61.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 13:45 +0100, christoph wrote:
> On Tue, Mar 07, 2006 at 04:23:02PM -0800, Badari Pulavarty wrote:
> > This patch removes readv() and writev() methods and replaces
> > them with aio_read()/aio_write() methods.
> 
> you have the io_fn_t/io_fnv_t typedefs both in read_write.c and
> read_write.h - they really should be in the latter only.

Taken care of.

I am not sure if you noticed or not ..

iocb->ki_left holds the amount of IO that needs to be done. So
we can use it instead of looping through iovecs to calculate
length. All we need to do is, we need to set it correctly in
sync case.

Thanks,
Badari

