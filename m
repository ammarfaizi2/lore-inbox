Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbWH2Sxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbWH2Sxg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbWH2Sxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:53:36 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47253 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965133AbWH2Sxf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:53:35 -0400
Subject: Re: 0x7f in SectorIdNotFound errors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martin Dorey <mdorey@bluearc.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <CECD6E8A589E8447BC6E836C8369AFF50AAE293D@us-email.terastack.bluearc.com>
References: <CECD6E8A589E8447BC6E836C8369AFF50AAE293D@us-email.terastack.bluearc.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 29 Aug 2006 20:15:38 +0100
Message-Id: <1156878938.6271.124.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-08-28 am 12:56 -0700, ysgrifennodd Martin Dorey:
> Aug 14 01:10:33 ithaki kernel: hdb: drive_cmd: status=0x7f { DriveReady
> DeviceFault SeekComplete DataRequest CorrectedError Index Error }
> 
> In hex, that LBAsect is 0x17f7f7f7f7f.  The disk is:

That may well have been f7f7f7f7f7... because several bits will have
been masked (its not 32bit addressed at controller<>device level)

> FS is ext3.  smartctl didn't report any errors but, then, it wouldn't
> necessarily if the problem was garbage fs metadata.  I found a few other
> LKML postings with 0x7f patterns in part of the LBAsect.

If you force an fsck do you see any errors ? I guess not but if you have
a chance to check please do.

I'm not sure where F7 came from as it is not a poison value we typically
use. The fact the value is odd is also significant. Most of the kernel
deals in 1K block sizes so any error/corruption occurred fairly low down
once we got into sectors. That seems to rule out, for example, ext3
metadata corruption because it would be very strange drive geometry to
start a partition on an odd sector boundary, and the ext3 meta data
doesn't go down to sector granularity.

Alan

