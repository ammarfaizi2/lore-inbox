Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWEFRWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWEFRWh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 13:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWEFRWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 13:22:37 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:58229 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751010AbWEFRWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 13:22:36 -0400
Date: Sat, 06 May 2006 11:20:16 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: High load average on disk I/O on 2.6.17-rc3
In-reply-to: <200605052139.49241.jasons@pioneer-pra.com>
To: Jason Schoonover <jasons@pioneer-pra.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <445CDAD0.1000203@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <69c8K-3Bu-57@gated-at.bofh.it> <445BDBED.7050101@shaw.ca>
 <200605052139.49241.jasons@pioneer-pra.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Schoonover wrote:
> Hi Robert,
> 
> There are, this is the relevant output of the process list:
> 
>  ...
>  4659 pts/6    Ss     0:00 -bash
>  4671 pts/5    R+     0:12 cp -a test-dir/ new-test
>  4676 ?        D      0:00 [pdflush]
>  4679 ?        D      0:00 [pdflush]
>  4687 pts/4    D+     0:01 hdparm -t /dev/sda
>  4688 ?        D      0:00 [pdflush]
>  4690 ?        D      0:00 [pdflush]
>  4692 ?        D      0:00 [pdflush]
>  ...
> 
> This was when I was copying a directory and then doing a performance test with 
> hdparm in a separate shell.  The hdparm process was in [D+] state and 
> basically waited until the cp was finished.  During the whole thing there 
> were up to 5 pdflush processes in [D] state.
> 
> The 5 minute load average hit 8.90 during this test.
> 
> Does that help?

Well, it obviously explains why the load average is high, those D state 
processes all count in the load average. It may be sort of a cosmetic 
issue, since they're not actually using any CPU, but it's still a bit 
unusual. For one thing, not sure why there are that many of them?

You could try enabling the SysRq triggers (if they're not already in 
your kernel/distro) and doing Alt-SysRq-T which will dump the kernel 
stack of all processes, that should show where exactly in the kernel 
those pdflush processes are blocked..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

