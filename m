Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVDZNF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVDZNF5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 09:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVDZNF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 09:05:57 -0400
Received: from colin.muc.de ([193.149.48.1]:19216 "EHLO colin2.muc.de")
	by vger.kernel.org with ESMTP id S261502AbVDZNFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 09:05:49 -0400
Date: 26 Apr 2005 15:05:48 +0200
Date: Tue, 26 Apr 2005 15:05:47 +0200
From: Andi Kleen <ak@muc.de>
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: Valdis.Kletnieks@vt.edu, Kyle Moffett <mrmacman_g4@mac.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Message-ID: <20050426130547.GE65287@muc.de>
References: <4263275A.2020405@lab.ntt.co.jp> <m1y8b9xyaw.fsf@muc.de> <426C51C4.9040902@lab.ntt.co.jp> <e83d0cb60cb50a56b38294e9160d7712@mac.com> <426CC8F7.8070905@lab.ntt.co.jp> <200504251636.j3PGa9SJ015388@turing-police.cc.vt.edu> <426D9AC0.5020908@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426D9AC0.5020908@lab.ntt.co.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 10:34:56AM +0900, Takashi Ikebe wrote:
> I think that's the common sense in every carrier.
> If we reboot the switch, the service will be disrupted.
> The phone network is lifeline, and does not allow to be disrupt by just 
> bug fix.
> I think same kind of function is needed in many real 
> enterprise/mission-critical/business area.
> 
> All do with ptrace may affect target process's time critical task. (need 
> to stop target process whenever fix)

Sorry, but what are your exact time requirements for this? 

Remember any x86-64 CPU is really fast and it can do a _lot_ of ptrace
operations in a very short time.

Just a vague "it may be too slow" is not enough justification to 
push a lot of redundant code into the kernel. Also if ptrace
should be really too slow (which I doubt, but you are welcome
to show some numbers together with real time requirements from
a real system) then we could optimize ptrace for this, e.g.
by adding a ptrace subcommand to copy whole memory blocks
more efficiently or maybe even do a mmap like thing.

But unless someone actually demonstrates this is needed it seems far overkill. 

> All implement in user application costs too much, need to implement all 
> the application...(and I do not know this approach really works on time 
> critical applications yet.)

I think you have a lot of unproved and doubtful assumptions here.

-Andi
