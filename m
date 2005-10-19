Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbVJSPvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVJSPvJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 11:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbVJSPvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 11:51:08 -0400
Received: from qproxy.gmail.com ([72.14.204.192]:223 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751120AbVJSPvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 11:51:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=L95Ng9j860zfW7dAGeisPjAgXbuByi7Tsyavs3l2hbMvO2cEv5t09+Z412BXMior2dgpeVAPr7DqibcoP/AMABz/qsDriHOYfYcl1uyFdcN18ABEu2uHs+REmNowYMWUpKk1JeeFDZ/ygc8JR2mkIAt+TsRCDXeYutRhJqj64ww=
Subject: Re: Is ext3 flush data to disk when files are closed?
From: Badari Pulavarty <pbadari@gmail.com>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4ae3c140510190831j7530742aqc2b82e9e9cd6dde3@mail.gmail.com>
References: <4ae3c140510190831j7530742aqc2b82e9e9cd6dde3@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 08:50:26 -0700
Message-Id: <1129737026.23632.113.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 11:31 -0400, Xin Zhao wrote:
> As far as I know, if an application modifies a file on an ext3 file
> ssytem, it actually change the page cache, and the dirty pages will be
> flushed to disk by kupdate periodically.
> 
> My question is: if a file is to be closed, but some of its data pages
> are marked as dirty, will system block on close() and wait for dirty
> pages being flushed to disk? If so, it seems to decrease performance
> significantly if a lot of updates on many small files are involved.
> 
> Can someone point me to the right place to check how it works? Thanks!

On the last close() of the file, it should be flushed through ..

	iput_final() -> generic_drop_inode() -> write_inode_now()
		-> __writeback_single_inode() -> __sync_single_inode()
			-> do_writepages()


Thanks,
Badari

