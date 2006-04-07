Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWDGU6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWDGU6e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 16:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWDGU6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 16:58:34 -0400
Received: from uproxy.gmail.com ([66.249.92.173]:28552 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964834AbWDGU6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 16:58:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=EW/+/hWpWZvyXtPuZ9EqxyUEiFuGlJhEKgu/ufKK/u4mSmpvmMje1qLfq015xOv7u1CkfQWR5RBr4CvO/9WnOnKVzus6p29HBNEze+Drnol9cwGAEk9BhjOahWR3aqL+HFVOWm8e0haL9JeGFnWsuPBsCY2gIAr5HtHZB7qktCQ=
Message-ID: <4436D275.2010402@gmail.com>
Date: Fri, 07 Apr 2006 16:58:29 -0400
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.17-rc1-mm1 - detects buggy TSC on GEODE
References: <20060404014504.564bf45a.akpm@osdl.org>
In-Reply-To: <20060404014504.564bf45a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI, 

as the 2 syslog extracts show;
1.   the new kernel is now detecting the buggy TSC on the GEODE-sc1100
2.    the bug is apparently correctable by passing 'idle=poll' on kernel 
boot-line.

Heres one vendor's bug/erratta description:
    http://soekris.com/Issue0003.htm


Apr  7 11:42:01 truck kernel: [   19.160016] Kernel command line: 
console=ttyS0,115200n81 root=/dev/nfs 
nfsroot=192.168.42.1:/nfshost/soekris 
nfsaddrs=192.168.42.100:192.168.42.1:192.168.42.1:255.255.255.0:soekris:eth0 
panic=5   BOOT_IMAGE=vmlinuz-2.6.17-rc1-mm1-sk
Apr  7 11:42:01 truck kernel: [   24.314851] Time: tsc clocksource has 
been installed.
Apr  7 11:42:01 truck kernel: [   29.977802] TSC appears to be running 
slowly. Marking it as unstable
Apr  7 11:42:01 truck kernel: [   20.460000] Time: pit clocksource has 
been installed.


Apr  7 12:35:56 truck kernel: [   21.562573] Kernel command line: 
console=ttyS0,115200n81 root=/dev/nfs 
nfsroot=192.168.42.1:/nfshost/soekris 
nfsaddrs=192.168.42.100:192.168.42.1:192.168.42.1:255.255.255.0:soekris:eth0 
panic=5  idle=poll BOOT_IMAGE=vmlinuz-2.6.17-rc1-mm1-sk
Apr  7 12:35:56 truck kernel: [   21.563049] using polling idle threads.
Apr  7 12:35:56 truck kernel: [   28.393469] Time: tsc clocksource has 
been installed.


Its nice to see the buggy TSC detector detect, and the work-around work.
