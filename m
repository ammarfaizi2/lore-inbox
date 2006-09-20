Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751758AbWITQ20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbWITQ20 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbWITQ20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:28:26 -0400
Received: from main.gmane.org ([80.91.229.2]:35002 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751755AbWITQ2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:28:25 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ludovic Drolez <ldrolez@linbox.com>
Subject: Poor scheduling when not loaded at 100% (Was: [PATCH] sched.c: Be a bit more conservative in SMP)
Date: Wed, 20 Sep 2006 16:26:19 +0000 (UTC)
Message-ID: <loom.20060920T181245-877@post.gmane.org>
References: <200609031541.39984.subdino2004@yahoo.fr>	 <200609031910.57259.vincent.plr@wanadoo.fr>	 <200609070130.53995.vincent.plr@wanadoo.fr>	 <loom.20060919T155900-330@post.gmane.org> <69304d110609191050w777a5c48ibe84bc0e3ce65df3@mail.gmail.com> <4510F0FD.4060602@linbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 81.56.128.63 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20060628 Debian/1.7.8-1sarge7.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ludovic Drolez <ldrolez <at> linbox.com> writes:
> In fact, I tested the 1st patch on our cluster (Finite elements computing on 8 
> CPUs):
> - Under Windows: 875 seconds
> - Linux 2.6.16 : 1019 s
> - Linux 2.6.16 + manual taskset : 842 s
> - Linux 2.6.16 + Vincent's patch : 1373 s  

Anyone has an idea why the scheduling is poor when processes don't use all CPU ?

In the above example, we have 4 processes on 4 processors which use about 40% of
the CPU (computing and waiting for network packets).
1- If taskset is not used : CPU0 is used at 80%, and the 3 others at 30%. The
tasks are constantly migrated between cores -> poor performance (1019s), Windows
does better :-(
2- If taskset is used : All CPUs have 1 process and are used at 40%. No
migration -> high performance (842s), better than Windows :-)

I tried to play with the 'migration_cost' kernel parameter but it did not help.
By default, on the Bi-Xeon Dual Core MB (Dell 1855), migration_cost=1600, and
trying values up to 200000, did not improve performance...

Any Ideas ?

  Ludovic Drolez.





