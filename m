Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVCUHlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVCUHlb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 02:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVCUHlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 02:41:31 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:24472 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261627AbVCUHlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 02:41:25 -0500
Date: Mon, 21 Mar 2005 08:41:24 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: forkbombing Linux distributions
In-Reply-To: <hils31h6au6i816ddi1r0vffgl0ithfde6@4ax.com>
Message-ID: <Pine.LNX.4.61.0503210833320.7472@yvahk01.tjqt.qr>
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
 <16958.16187.716183.994251@wombat.chubb.wattle.id.au>
 <hils31h6au6i816ddi1r0vffgl0ithfde6@4ax.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>William> Sure enough, I created the following script and ran it as a
>>William> non-root user:
>>
>>William> #!/bin/bash $0 & $0 &
>>
>>There are two approaches to fixing this.
>>  1.  Rate limit fork()
>>  2.  Limit (per user) the number of processes allowed
>
>Had to try it out of curiosity, five ssh logins at the time, 
>but I hit Ctrl-S on the terminal running forkbomb, then other 
>terminals responsive and I could recover, do 'killall forkbomb'.

By the time you killed a handful of procs, the other half spawned new ones.

You can try stopping forkbombs by "killall -STOP nameofprog" and then 
"killall -9 nameofprog".

But you probably won't get to run killall in case of a thrasher running within 
the limits of `ulimit -m` and `ulimit -u`:
  perl -e 'fork,$_="x"x 10E6 while 1'


Jan Engelhardt
-- 
