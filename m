Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWFGDLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWFGDLV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 23:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWFGDLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 23:11:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:13416 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750758AbWFGDLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 23:11:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eHO2KHp3Rl5vp8AH0P2VtkIjNTZQKj7y/Af+/QNCzN4IfGmqpOccI6Xrx5/3vuxgZFyZfGc0HQbCyetekiW7GcfzxJXPBVStU1Ln9WjePwxo1LkTXa/YbP1OF5C7+Ao6FVDa10O9YF/Id9ZL41PjkyssfU9s8ZgL3y8f9w7ipp8=
Message-ID: <787b0d920606062011j21083e80v659228a7565ecfab@mail.gmail.com>
Date: Tue, 6 Jun 2006 23:11:19 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: sithglan@stud.uni-erlangen.de, linux-kernel@vger.kernel.org
Subject: Re: AMD64: 64 bit kernel 32 bit userland - some pending questions
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Glanzmann writes:

> I would like to use an AMD64 Opteron System with a 64 bit Linux Kernel,
> but a 32 bit userland (Debian Sarge). I have a few questions about this:
>
> - Is it possible to give the userland 3Gbyte virtual address
>   space (default for 2.4 and 2.6). But give the Kernel a 64 bit
>   virtual address space so that I get more than 1 Gbyte physical
>   Memory into LOWMEM - say I want 8 Gbyte - without using HIGHMEM
>   at all? If this scenario is possible I would get cheap memory
>   access at the benefit of a well tested userland. I don't have
>   applications that need more than 2 Gbyte virtual address
>   space.

Why do you want cheap memory access? Normally people want this
for performance, but 32-bit apps are noticably slower.

The "well tested userland" is only well tested on a 32-bit kernel.
There are many ways in which a 64-bit kernel fails to correctly
run 32-bit apps. I just found one the other day, in the way signal
handler info gets translated from 64-bit to 32-bit. Some of your
userspace would be something I wrote, which I happen to know will
not run 100% correctly and I just don't care to "fix" it for your
wildly abnormal configuration.

I suspect you have a Windows mindset. In the Windows world, almost
nothing is 64-bit clean. Nearly every Linux app is well-tested in
64-bit form. This is because Linux was ported to the Alpha CPU
back around 1994, give or take a year. That's over a decade of
64-bit experience. It's mainly the proprietary apps that don't
run in 64-bit mode. The one big exception is OpenOffice, which
was also proprietary until Sun opened it up.

Just forget the old 32-bit crud if at all possible. Hopefully
you won't have even one 32-bit library or executable. Make it
your goal to eliminate this buggy cruft. You can use chroot()
or VMWare as needed, but cleaning house is so much nicer.

> - If the above scenario works out like I imagine it, does this
>   add some additional overhead I am not aware of when I switch
>   for example from 32 bit userland to 64 bit kernel space which
>   would override the performance gain I get from the huge LOWMEM
>   virtuall address space?

Of course there is overhead. There are also bugs, some of which
won't ever get fixed.

The bigger problem is that 32-bit code has fewer CPU registers.
(nobody has done an ILP32 ABI for long mode) This is slow.
