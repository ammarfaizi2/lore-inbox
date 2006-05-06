Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWEFElS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWEFElS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 00:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWEFElS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 00:41:18 -0400
Received: from mail.pioneer-pra.com ([65.205.244.70]:18340 "EHLO
	mail1.dmz.sj.pioneer-pra.com") by vger.kernel.org with ESMTP
	id S932438AbWEFElR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 00:41:17 -0400
From: Jason Schoonover <jasons@pioneer-pra.com>
Organization: Pioneer PRA
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: High load average on disk I/O on 2.6.17-rc3
Date: Fri, 5 May 2006 21:39:49 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <69c8K-3Bu-57@gated-at.bofh.it> <445BDBED.7050101@shaw.ca>
In-Reply-To: <445BDBED.7050101@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605052139.49241.jasons@pioneer-pra.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

There are, this is the relevant output of the process list:

 ...
 4659 pts/6    Ss     0:00 -bash
 4671 pts/5    R+     0:12 cp -a test-dir/ new-test
 4676 ?        D      0:00 [pdflush]
 4679 ?        D      0:00 [pdflush]
 4687 pts/4    D+     0:01 hdparm -t /dev/sda
 4688 ?        D      0:00 [pdflush]
 4690 ?        D      0:00 [pdflush]
 4692 ?        D      0:00 [pdflush]
 ...

This was when I was copying a directory and then doing a performance test with 
hdparm in a separate shell.  The hdparm process was in [D+] state and 
basically waited until the cp was finished.  During the whole thing there 
were up to 5 pdflush processes in [D] state.

The 5 minute load average hit 8.90 during this test.

Does that help?

Jason

-------Original Message-----
From: Robert Hancock
Sent: Friday 05 May 2006 16:12
To: linux-kernel
Subject: Re: High load average on disk I/O on 2.6.17-rc3

Jason Schoonover wrote:
> Hi all,
>
> I'm not sure if this is the right list to post to, so please direct me to
> the appropriate list if this is the wrong one.
>
> I'm having some problems on the latest 2.6.17-rc3 kernel and SCSI disk I/O.
> Whenever I copy any large file (over 500GB) the load average starts to
> slowly rise and after about a minute it is up to 7.5 and keeps on rising
> (depending on how long the file takes to copy).  When I watch top, the
> processes at the top of the list are cp, pdflush, kjournald and kswapd.

Are there some processes stuck in D state? These will contribute to the
load average even if they are not using CPU.
