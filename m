Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285286AbRLSNlP>; Wed, 19 Dec 2001 08:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285287AbRLSNlF>; Wed, 19 Dec 2001 08:41:05 -0500
Received: from mel.alcatel.fr ([212.208.74.132]:13292 "EHLO mel.alcatel.fr")
	by vger.kernel.org with ESMTP id <S285286AbRLSNku>;
	Wed, 19 Dec 2001 08:40:50 -0500
Message-ID: <3C2098D7.4228B2A5@sxb.bsf.alcatel.fr>
Date: Wed, 19 Dec 2001 14:40:39 +0100
From: Denis RICHARD <dri@sxb.bsf.alcatel.fr>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Pierre PEIFFER <Pierre.Peiffer@sxb.bsf.alcatel.fr>,
        Denis RICHARD <Denis.Richard@sxb.bsf.alcatel.fr>,
        Yves LUDWIG <Yves.Ludwig@sxb.bsf.alcatel.fr>
Subject: New version of e2compr for 2.4.16 kernel.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  We have developped a new version of the e2compr package for the 2.4.16 kernel.
It is based on the e2compr-0.4.39 patch provided by Peter Moulder
for 2.2.18 kernel (http://cvs.bofh.asn.au/e2compr/).
  It is full compatible with previous version.

  We have introduced the structure of "cluster of pages", as there was the structure
of "cluster of blocks" in preceding version. The compression unit is the cluster of
pages.

  The implementation is similar with the 2.2 version. If the page needed is not present
in memory, the cluster of pages including this one is decompressed.
  But in the 2.4 kernel the pages and the blocks have common area for the data.
If a block is read from the device, the corresponding page is also modified.
Then to decompress a cluster we should not read the blocks in the already used pages (decompressed)
of the cluster. These pages can have been modified or can be used by another process (mapping).
If a page is UPTODATE, a new one is allocated to decompress the cluster, and is freed after that.

  It has only been tested on i386 architecture, so be careful if you want to try it
on other architecture, and especially if pages are large and can belong to two different
clusters.

  For more informations, see the README files in Documentation/filesystems directory.

  If someone is interested by the patch, we will mail it.

  Feel free to contat us if you have some questions.

  Have fun.

 Pierre PEIFFER, Denis RICHARD .

PS : We have also adjusted the e2fsprogs patch for the last version (1.25).

--
-----------------------------\--------------------------\
Denis RICHARD                 \ ALCATEL Business Systems \
mailto:dri@sxb.bsf.alcatel.fr / Tel: +33(0)3 90 67 69 36 /
-----------------------------/--------------------------/



