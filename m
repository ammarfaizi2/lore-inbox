Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWFFK0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWFFK0V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 06:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWFFK0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 06:26:21 -0400
Received: from dwdmx4.dwd.de ([141.38.3.230]:21736 "EHLO dwdmx4.dwd.de")
	by vger.kernel.org with ESMTP id S1750770AbWFFK0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 06:26:20 -0400
Date: Tue, 6 Jun 2006 10:23:29 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: ext2-devel@lists.sourceforge.net, Andreas Dilger <adilger@clusterfs.com>
Subject: Question regarding ext3 extents+mballoc+delalloc
Message-ID: <Pine.LNX.4.61.0606061021330.31147@diagnostix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Looking at ways to increase write performance on my system using ext3
Andreas Dilger pointed me to delalloc+mballoc+extent patches. Downloaded
those from ftp://ftp.clusterfs.com/pub/people/alex/2.6.16.8 and run some
benchmark, here some results using bonnie++:

Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
2.6.16.19       16G 59223  91 264155  45 111459  36 57313  99 317944  63  1478   7
                     58814  92 276803  47 110418  36 57105  99 317534  65  1525   5
                     58299  92 274523  48 110290  36 56723  99 318839  65  1502   4

And here the results when mounting without extents,mballoc,delalloc option:


Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
2.6.16.19       16G 38621  98 194816  94 87776  49 37921  92 239128  54  1402   5
                     47000  99 194276  94 89232  49 38628  92 240539  55  1399   5
                     45873  98 178195  90 89726  50 38482  92 240490  55  1381   4

So using delalloc+mballoc+extent gives an approx. 30% increase in performance.

Using my own benchmark afdbench where many process copy thousands of files
around, the results are as follows:

With extents,mballoc,delalloc

      5488.36 files per second 14.19 MB/s

Without extents,mballoc,delalloc

      4829.84 files per second 12.72 MB/s

The performance increase is approx. 12%.

So the question is, why are these patches not included into the kernel?
I did some very extensive testing for several days and could not discover
any disadvantage using those patches. I must add that I did not test
crashes to see if data is lost. Are there any disadvantages using these
patches?

Please CC me since I am not subscribed to the list.

Thanks,
Holger
-- 

