Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWJaCiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWJaCiv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 21:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWJaCiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 21:38:50 -0500
Received: from smtp-out.google.com ([216.239.45.12]:9937 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751319AbWJaCiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 21:38:50 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:mime-version:
	content-type:content-transfer-encoding:content-disposition;
	b=E8DYK4BdtI6HlgPHhUVgzAfQk1fa8w4eV0h1gRaG4WFPPRYwZBNEZaWQgKrnokkaS
	Myhsgf3TXsFNEkAegDPLQ==
Message-ID: <6599ad830610301838i65a00d85g82647435ea4581a4@mail.gmail.com>
Date: Mon, 30 Oct 2006 18:38:41 -0800
From: "Paul Menage" <menage@google.com>
To: "Andrew Morton" <akpm@osdl.org>, "Paul Jackson" <pj@sgi.com>
Subject: [PATCH] Allow a larger buffer for writes to cpuset files
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When using fake NUMA setup, the number of memory nodes can greatly
exceed the number of CPUs. So the current limit in
cpuset_common_file_write() is insufficient. PAGE_SIZE is still a bit
of an arbitrary limit, but gives more breathing room.

Signed-off-by: Paul Menage <menage@google.com>

--- 2.6.19-rc2.orig/kernel/cpuset.c
+++ 2.6.19-rc2/kernel/cpuset.c
@@ -1292,7 +1292,7 @@ static ssize_t cpuset_common_file_write(
 	int retval = 0;

 	/* Crude upper limit on largest legitimate cpulist user might write. */
-	if (nbytes > 100 + 6 * NR_CPUS)
+	if (nbytes >= PAGE_SIZE)
 		return -E2BIG;

 	/* +1 for nul-terminator */
