Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261639AbRFGPjl>; Thu, 7 Jun 2001 11:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261628AbRFGPjb>; Thu, 7 Jun 2001 11:39:31 -0400
Received: from www.wen-online.de ([212.223.88.39]:20233 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261595AbRFGPjW>;
	Thu, 7 Jun 2001 11:39:22 -0400
Date: Thu, 7 Jun 2001 17:38:39 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Bulent Abali <abali@us.ibm.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Derek Glidden <dglidden@illusionary.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <OF75B67BC7.4C70DAF5-ON85256A64.004C4AD1@pok.ibm.com>
Message-ID: <Pine.LNX.4.33.0106071641020.332-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jun 2001, Bulent Abali wrote:

> I happened to saw this one with debugger attached serial port.
> The system was alive.  I think I was watching the free page count and
> it was decreasing very slowly may be couple pages per second.  Bigger
> the swap usage longer it takes to do swapoff.  For example, if I had
> 1GB in the swap space then it would take may be an half hour to shutdown...

I took a ~300ms ktrace snapshot of the no IO spot with 2.4.4.ikd..

  % TOTAL    TOTAL USECS    AVG/CALL   NCALLS
  0.0693%         208.54        0.40      517 c012d4b9 __free_pages
  0.0755%         227.34        1.01      224 c012cb67 __free_pages_ok
  ...
 34.7195%      104515.15        0.95   110049 c012de73 unuse_vma
 53.3435%      160578.37      303.55      529 c012dd38 __swap_free
Total entries: 131051  Total usecs:    301026.93 Idle: 0.00%

Andrew Morton could be right about that loop not being wonderful.

	-Mike

