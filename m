Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267798AbUHEXDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267798AbUHEXDn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 19:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267752AbUHEXDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 19:03:43 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:42653 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S267727AbUHEXDc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 19:03:32 -0400
Message-ID: <4112BC7A.1040102@rtr.ca>
Date: Thu, 05 Aug 2004 19:02:18 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: BUG: SCSI SYNCHRONIZE_CACHE on driver unload
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On module removal of a SCSI Low-Level Driver (LLD),
the mid-layer tries to do a SYNCHRONIZE_CACHE
command to each device on each host of that driver.

But the command is issued *after* setting SHOST_CANCEL,
which means that scsi_dispatch_cmd() will *always*
fail the command inline, without passing to the LLD.

This bug shows up only for hosts/drives which support
a write-back caching scheme.  For the more common
write-thru scheme, the SYNCHRONIZE_CACHE command is
never issued, so the bug never manifests.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
