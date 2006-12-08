Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424631AbWLHFeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424631AbWLHFeK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 00:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424633AbWLHFeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 00:34:09 -0500
Received: from smtp43.singnet.com.sg ([165.21.103.151]:34256 "EHLO
	smtp43.singnet.com.sg" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424631AbWLHFeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 00:34:06 -0500
Message-ID: <4578F982.70506@homeurl.co.uk>
Date: Fri, 08 Dec 2006 13:34:58 +0800
From: Bob <spam@homeurl.co.uk>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6 SMP very slow with ServerWorks LE Chipset
References: <4577AA11.6020906@homeurl.co.uk> <20061207110737.6c506c98@localhost.localdomain>
In-Reply-To: <20061207110737.6c506c98@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
>> As a test of raw CPU power I've been decompressing the kernel tree, with 
>> a UP 2.6 kernel this takes about 1m 15s, I don't know if bz2 is 
>> multithreaded but even if it's not I would expect a slight speed increase 
>> but in fact with a SMP 2.6 kernel it take 13 ~ 26m, with a SMP 2.4 
>> kernel it takes 1m 28s and with a 2.4 UP 1m 35s. 
> 
> The 2.4 numbers look correct (slightly slower), the 2.6 numbers do not.
> 
> 
> Nothing obviously wrong from the traces however. If you pin the bzip to a
> given processor do you get different results according to which CPU ?
> 
> (see man taskset for info on the commands)
> 
> If you get very different times on the two processors that will be very
> useful information.

Mmm CPU 0 in 1m 32s, but I was running things like ps and taskset in 
another terminal to verify affinity, CPU 1 still hadn't finished in 40m 
when I killed it. I've downloaded the LFDK mentioned in the other post 
and will post the results when I have them.

Thanks for replying,

This is the script I'm using to time decompression
nas:~# cat ./cputest.sh
date
taskset -c 1 nice -n -8 tar -xjf /root/linux-2.6.18.1.tar.bz2
date
uname -a
rm -r /root/linux-2.6.18.1/
nas:~#

both the tar and bzip2 processes have their affinity and priority set by 
the above command.
