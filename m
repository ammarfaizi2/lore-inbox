Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWBVV5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWBVV5E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 16:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWBVV5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 16:57:03 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:34785 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750818AbWBVV47 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 16:56:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DrOsudGzX9LoW4pXK/l3R75K9nJPcaA2xKLdXjwsuCL9ykWBEoiyqxEjThcnCAVUqSQCJVZsDFyjueGoRU9gRcF/DRLCVZ10aKli/TY8SDR4TMPjOzW3LGCItrzEV8XlmlONBrnNRQF6tHq9W+BDWqLPmLmI97yQlLpbtKd4yzI=
Message-ID: <4ae3c140602221356x15015171h5aa4a3d7bb6034e0@mail.gmail.com>
Date: Wed, 22 Feb 2006 16:56:57 -0500
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: question about possibility of data loss in Ext2/3 file system
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I know, in Ext2/3 file system, data blocks to be flushed to
disk are usually marked as dirty and wait for kernel thread to flush
them lazily. So data blocks of a file could be flushed even after this
file is closed.

Now consider this scenario: suppose data block 2,3 and 4 of file A are
marked to be flushed out. At time T1, block 2 and 3 are flushed, and
file A is closed. However, at time T2, system experiences power outage
and failed to flushed block 4. Does that mean we will end up with
getting a partially flushed file?  Is there any way to provide better
guarantee on file integrity?
