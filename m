Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318905AbSH1TO4>; Wed, 28 Aug 2002 15:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318907AbSH1TO4>; Wed, 28 Aug 2002 15:14:56 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:63223 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318905AbSH1TOz>; Wed, 28 Aug 2002 15:14:55 -0400
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dominik Brodowski <devel@brodo.de>, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0208281140030.4507-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0208281140030.4507-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 28 Aug 2002 20:21:34 +0100
Message-Id: <1030562494.7190.53.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   "What is worse is that the interface is, in my opinion, fundamentally
>    broken for *ALL* CPUs.  It doesn't present a policy interface to the
>    kernel, instead it presents a frequency-setting interface and expect
>    the policy to be done in userspace.  The kernel is the only part of the
>    system which has sufficient information (idle times of all CPUs, for
>    example) to do a decent job managing the CPU frequency efficiently.  
>    On Transmeta CPUs this policy should simply be passed down to CMS, of
>    course; on other CPUs the kernel needs to manage it."

You might want to read the paper on the original cpufreq for ARM. It
gives real world cases where the user -needs- to be able to control the
policy. I think you misunderstand what the interface is about. Large
numbers of systems benefit from usermode policy engines.

cpufreq is an interface that allows the user to control the processor
speed. Period. It is not a policy, it is not a management system. Its
business stops at "don't blow up the computer". It enables user space
policies to be handled. It sequences events and notifies device drivers
so they can handle speed changes that affect them. (eg reclocking the
serial ports on the AMD Elan)

If you need a kernel policy engine then that should be a completely
seperate module. The cpufreq interface hs to provide "please change
speed" methods to the kernel. We already have one example of a kernel
policy engine that wants this facility. That is ACPI with native
processor speed control. ACPI is simply one possible policy engine. 

Cpufreq is to power management as /dev/hda is to file systems.


Alan

