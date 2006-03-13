Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751736AbWCMLjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbWCMLjr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 06:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbWCMLjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 06:39:46 -0500
Received: from [212.76.85.224] ([212.76.85.224]:19204 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751736AbWCMLjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 06:39:46 -0500
From: Al Boldi <a1426z@gawab.com>
To: Marr <marr@flex.com>
Subject: Re: Readahead value 128K? (was Re: Drastic Slowdown of 'fseek()'
Date: Mon, 13 Mar 2006 14:37:50 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603131437.50461.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marr wrote:
> The 2.6.13 kernel on ReiserFS (without using 
> 'nolargeio=1' as a mount option) still takes about 4m35s to fseek 200,000 
> times on that 4MB file, even with 'hdparm -a0 /dev/hda' in effect.

try this magic number:

        echo 192 > /sys/block/hda/queue/max_sectors_kb
        echo 192 > /sys/block/hda/queue/read_ahead_kb

Anything outside 132-255 affects throughput negatively.

Also, can you dump hdparm -I /dev/hda?

Thanks!

--
Al

