Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263498AbTJQSYd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 14:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263562AbTJQSYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 14:24:03 -0400
Received: from bcsii.com ([67.114.178.171]:50619 "EHLO mail.bcsii.com")
	by vger.kernel.org with ESMTP id S263498AbTJQSX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 14:23:58 -0400
Message-ID: <3F9034BB.1000800@bcsii.net>
Date: Fri, 17 Oct 2003 11:28:11 -0700
From: Andriy Rysin <arysin@bcsii.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20, 2.4.22, 2.4.6-test7: system locks up completely when
 writing to floppy (2.2.20 is ok) - solution
References: <Pine.LNX.4.44.0310061946290.2403-100000@logos.cnet> <3F8DC990.1040203@bcsii.net>
In-Reply-To: <3F8DC990.1040203@bcsii.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andriy Rysin wrote:

> I've got two motherboards on which I have this problem, they're ASUS 
> P4S533-X and P4S533-MX. When I am trying to write something to a 
> floppy the system hangs completely. dd, mkfs or mount + cp are all the 
> sme. The floppy does several writing sounds and that's it, the light 
> is on. No oppses, no panic no log/console messages. I have this with 
> 2.4.20, 2.4.22 both from RedHat and 2.4.6-test7 from 
> http://people.redhat.com/arjanv/2.5/RPMS.kernel/
> I don't have this with DOS :) or linux 2.2.20 from tomsrtbt floppy and 
> I don't have this on any other motherboards.
> I changed floppy, changed floppy cable, tried different BIOS settings, 
> changed video card, changed hardrives, booted in S mode. Reproducible 
> 100%.
> It seems pretty like this message 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0202.2/1557.html
> dmesg from 2.4.22 is below.
> Please CC me if you reply or need more info.

Ok, I've tested kernels from 2.4.0 to 2.4.22 and found that it's a 
CONFIG_APM_CPU_IDLE=y which causes machine to hang. It seems like on 
ASUS P4533 motherboards this option is unsafe so it must be turned off. 
In RedHat kernels they turned on it after 2.4.18 that's why I saw the 
hangs. Actually the option help says that some machine may hang and 
probably it should not be on by default. Luckily I was able to fix that 
adding "apm=idle_threshold=100" to the kernel parameters without 
recompiling the kernel.
Maybe these motherboards/BIOS should be blacklisted?

Andriy

