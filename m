Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbVLEStM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbVLEStM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVLEStM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:49:12 -0500
Received: from javad.com ([216.122.176.236]:34572 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S1751405AbVLEStK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:49:10 -0500
From: Sergei Organov <osv@javad.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sergey Vlasov <vsu@altlinux.ru>, linux-kernel@vger.kernel.org
Subject: Re: SATA ICH6M problems on Sharp M4000
References: <200511221013.04798.marekw1977> <87u0dri996.fsf@javad.com>
	<20051205202228.13232c10.vsu@altlinux.ru> <874q5nfm1e.fsf@javad.com>
	<439484EC.5080406@pobox.com>
Date: Mon, 05 Dec 2005 21:48:57 +0300
In-Reply-To: <439484EC.5080406@pobox.com> (Jeff Garzik's message of "Mon, 05
	Dec 2005 13:20:28 -0500")
Message-ID: <87u0dne5wm.fsf@javad.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.17 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:
> Sergei Organov wrote:
>> Sergey Vlasov <vsu@altlinux.ru> writes:
>>
>>>On Fri, 02 Dec 2005 22:33:57 +0300 Sergei Organov wrote:
>>>
>>>
>>>>Sorry, but provided ata_piix has ignored the optical drive, couldn't
>>>>corresponding I/O resource be left free so that subsequently loaded,
>>>>say, generic-ide module is able to get over and support the drive?
>>>>
[...]
>>>See http://lkml.org/lkml/2005/10/18/167 and the reply to it :-\
>> Well, Jef's answer was:
>>
>>   This is a reasonable point, but the rare person who runs modular
>>   IDE on these PATA/SATA combined mode beasts can certainly tell the
>>   IDE driver to not probe certain ports.
>>
>> I can say that the kernel I have problem with is from Debian
>> "testing" distribution so those "rare person" going to become quite a
>> few in the near future. Besides, Debian loads ata_piix first, then
>> IDE, so telling the IDE to ignore certain ports won't help.  Though
>> one can argue that that's yet another distribution problem, I fail to
>> see a way for a distribution to overcome the problem provided it
>> doesn't know the exact hardware it will run on. No hope for
>> modularized kernel to run out of the box on given hardware?
>>
>> Jeff, is there any hope it will be fixed in the kernel.org sources,
>> or should I report the problem to Debian instead so that they consider
>> maintaining their own patch?
>
> Debian doesn't need to maintain a patch, they should load modules in the 
> proper order.

Do you mean that IDE then ata_piix is the right order? If so then the
following arguments arise:

1. It still won't work out-of-the-box as some IDE ports should be
explicitly disabled depending on particular hardware to get reasonable
performance of the hard-drive (changing of device name from hd to sd at
this point is another trouble). I don't think it's an acceptable
solution for a distribution kernel.

2. I doubt it's a good idea for the kernel in general to depend on
particular order of loading of modules when no explicit dependencies
between the modules are specified.

3. Loading IDE first somewhat suggests IDE should be preferred over
libata. Is it indeed true? ;)

Besides, does your answer mean that it won't indeed be changed in the
official kernel or it's undecided yet?

-- Sergei.
