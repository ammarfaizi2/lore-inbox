Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTHFPDi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 11:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263952AbTHFPDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 11:03:38 -0400
Received: from mail.gondor.com ([212.117.64.182]:11531 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S263638AbTHFPDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 11:03:36 -0400
Date: Wed, 6 Aug 2003 17:03:35 +0200
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Subject: uncorrectable ext2 errors
Message-ID: <20030806150335.GA5430@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

A few days ago, I reported some problems with a ext2 filesystem which I
cannot repair with e2fsck. Now I got some new observations.

To summarize the problem: e2fsck reports block bitmap differences, but
telling it to repair these doesn't help, another e2fsck run reports the
same differences.

Now I took a copy of the metadata with e2image -r, and ran e2fsck on
that. Surprisingly, now e2fsck was able to repair the differences.

With this corrected filesystem, I took a look at what e2fsck did change
on the filesystem. Interestingly, the errors are very systematic. It's
mainly sequences of 4096 bytes which should be all 255, but are
3,0,0,0,300,7,0,... (rest are 0s). These blocks start at the following 
positions:

6630000001
6638000001
6640000001
6648000001
6748000001
6750000001
6758000001
6760000001
6768000001
6790000001
6798000001
67A0000001
67A8000001
67B0000001
67B8000001
67C0000001
67C8000001
67D0000001
67D8000001
67E0000001
67E8000001

To me, this looks like some strange problem in a layer below the
filesystem. So it may be LVM, ide, promise ide driver, or a hardware
fault.

Do you have any idea how to further diagnose this?

Jan

