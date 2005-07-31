Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVGaCTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVGaCTO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 22:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVGaCTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 22:19:14 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8348 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261522AbVGaCTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 22:19:12 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org
Subject: Re: ALSA, snd_intel8x0m and kexec() don't work together
 (2.6.13-rc3-git4 and 2.6.13-rc3-git3)
References: <20050721180621.GA25829@charite.de>
	<20050722062548.GJ25829@charite.de>
	<200507221614.28096.vda@ilport.com.ua>
	<20050722131825.GR8528@charite.de> <1122054941.877.6.camel@mindpipe>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 30 Jul 2005 20:19:00 -0600
In-Reply-To: <1122054941.877.6.camel@mindpipe> (Lee Revell's message of
 "Fri, 22 Jul 2005 13:55:41 -0400")
Message-ID: <m1fytv1zvv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:

> On Fri, 2005-07-22 at 15:18 +0200, Ralf Hildebrandt wrote:
>> * Denis Vlasenko <vda@ilport.com.ua>:
>> 
>> > Not happening here on 2.6.12:
>> 
>> 2.6.12 didn't have kexec (unless it's a -mm kernel)
>> So how could you boot using kexec then?
>> 
>
> Is kexec supposed to be transparent to all the subsystems, or does ALSA
> have to know how to stop all DMA in order for kexec to work?

It is fairly transparent.  device_shutdown on reboot should stop
DMA but that is not kexec specific.  kexec may be the only way
the code path is easily tested.

The basic requirement from the kexec side is that the drivers
be able to bring back the device from the state they left it
on reboot.

So in essence it is transparent.  But if your driver is not
robust you can have problems.

The fact the new kernel was coming up indicates that kexec
worked but the driver did not successfully initialize,
the hardware from the state it placed it in during shutdown.

Eric
