Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261659AbSJQCrL>; Wed, 16 Oct 2002 22:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261661AbSJQCrL>; Wed, 16 Oct 2002 22:47:11 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:37388
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261659AbSJQCrK>; Wed, 16 Oct 2002 22:47:10 -0400
Subject: benchmarks of O_STREAMING in 2.5
From: Robert Love <rml@tech9.net>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Oct 2002 22:53:20 -0400
Message-Id: <1034823201.722.429.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I gave the O_STREAMING in Andrew's 2.5-mm tree the treatment..

Short summary: It works.

The streaming read test in the following benchmarks is simply a read()
in 64KB byte chunks of an 800MB file.

First test.  Show the cache effects are indeed as we intend and the
overhead is negligible.  Here, mem=2G.

	O_STREAMING?	Wall time	Cache Delta
	Yes		21.827s		0
	No		21.734s		+800MB

Second test.  Same deal, but mem=8M.  There was slight swapping, so I
suspect the reduced VM pressure is why the O_STREAMING run is faster.

	O_STREAMING?	Wall time	Cache Delta
	Yes		22.303s		0
	No		28.812s		+1MB

Third and final test. Kernel compile (make -j2) with a couple streaming
reads in the background.  Again, mem=2G.  This shows that actually
saving the pagecache from the horrid waste is useful.

	O_STREAMING	Wall time to complete Kernel compile
	Yes		5m30.494s
	No		4m59.661s

So, uh, Andrew's 2.5 code works ;-)

Someone buy me a dual Xeon,

	Robert Love

