Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276057AbRKFALZ>; Mon, 5 Nov 2001 19:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281438AbRKFALF>; Mon, 5 Nov 2001 19:11:05 -0500
Received: from domino1.resilience.com ([209.245.157.33]:21477 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S276057AbRKFALA>; Mon, 5 Nov 2001 19:11:00 -0500
Message-ID: <3BE7294E.5050905@usa.net>
Date: Mon, 05 Nov 2001 16:05:34 -0800
From: Eric <ebrower@usa.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010802
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [Q] pivot_root and initrd
In-Reply-To: <p05100304b80cbe9cf127@[10.128.7.49]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas wrote:

>> linuxrc does 'exec chroot', chroot does 'exec sh', 
>> sh does 'exec init'.
>> Thus init should end up with the same pid as linuxrc.

Exactly, but if init does not have PID 1, we fail.  Kai,
it works for HPA because of the magic kernel command line
incantation:

	root=/dev/ram0 (apparently with or without devfs)

Without this, init does NOT get PID 1 and therefore it
all goes south rather quickly.  The pivot_root syscall
is handy, but its operation under 2.4.x is disingenuous
at best.

E

