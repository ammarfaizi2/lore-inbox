Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317345AbSGRIpb>; Thu, 18 Jul 2002 04:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317421AbSGRIpb>; Thu, 18 Jul 2002 04:45:31 -0400
Received: from tolkor.SGI.COM ([192.48.180.13]:30941 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S317345AbSGRIpb>;
	Thu, 18 Jul 2002 04:45:31 -0400
Subject: O_DIRECT read and holes in 2.5.26
From: Stephen Lord <lord@sgi.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Jul 2002 03:43:08 -0500
Message-Id: <1026981790.1258.17.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew, 

Did you realize that the new O_DIRECT code in 2.5 cannot read over holes
in a file. The old code filled the user buffer with zeros, the new code
returned EINVAL if the getblock function returns an unmapped buffer.
With this exception, XFS does work with the new code - with more cpu
overhead than before due to the once per page getblock calls.

Steve



