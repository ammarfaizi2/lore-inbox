Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUJIAOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUJIAOK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 20:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUJIAOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 20:14:10 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:17340 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S266304AbUJIAOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 20:14:05 -0400
Message-ID: <41672D4A.4090200@nortelnetworks.com>
Date: Fri, 08 Oct 2004 18:14:02 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [BUG]  oom killer not triggering in 2.6.9-rc3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have an Xserve running 2.6.9-rc3 and patched to run the ppc kernel rather than 
the ppc64 kernel.  It's configured with 2GB of memory, no swap.

If I run one instance of the following program, it allocates all but about 3MB 
of memory, and the memory hog spins with 100% of the cpu.

If I run two instances of the program, the machine locks up, doesn't respond to 
pings, and is basically dead to the world.

Shouldn't the oom-killer be kicking in?

Chris







#include <stdlib.h>
#include <unistd.h>

#define PAGES 1000
#define BLOCKSIZE (pgsz * PAGES)

int main()
{
	int pgsz = sysconf(_SC_PAGESIZE);

	while(1) {
		char *p = (char *)malloc(BLOCKSIZE);
		if (p)
			for (int i=0;i<PAGES;i++)
				*(p+(i*pgsz)) = 1;
	}
	return 0;
}
