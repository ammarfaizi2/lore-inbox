Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbVIWAgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbVIWAgY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 20:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVIWAgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 20:36:24 -0400
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:25254 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751236AbVIWAgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 20:36:23 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Valdis.Kletnieks@vt.edu
Subject: Re: 2.6.14-rc2-mm1 - ext3 wedging up
Date: Fri, 23 Sep 2005 10:36:16 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200509221959.j8MJxJsY010193@turing-police.cc.vt.edu>
In-Reply-To: <200509221959.j8MJxJsY010193@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509231036.16921.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2005 05:59, Valdis.Kletnieks@vt.edu wrote:
> Am seeing reproducible wedging up when writing large (20M+) files to an
> ext3 file system.  Oddly enough, if something *else* writes files to the
> file system as well, it will unwedge for a while and make progress.  Also,
> a 'sync' command will relieve things temporarily - but after a few
> megabytes it comes to a halt again.  Looks like a borkage someplace not
> causing it to actually finish pushing dirty file pages out - gkrellm
> reports little/no disk activity in progress. File activity on *other*
> filesystems continues unimpeded.


Could be the write throttling patches.

Try backing these out (in this order I think):

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm1/broken-out/per-task-predictive-write-throttling-1-tweaks.patch
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm1/broken-out/per-task-predictive-write-throttling-1.patch

Cheers,
Con
