Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbTIJLQV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 07:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbTIJLQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 07:16:21 -0400
Received: from 11.ylenurme.ee ([193.40.6.11]:61677 "EHLO linking.ee")
	by vger.kernel.org with ESMTP id S262230AbTIJLQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 07:16:18 -0400
Message-ID: <37546.195.80.106.123.1063195928.squirrel@mail.linking.ee>
Date: Wed, 10 Sep 2003 14:12:08 +0200 (EET)
Subject: Re: softraid + serverraid locking FS
From: <elmer@linking.ee>
To: <arjanv@redhat.com>
In-Reply-To: <1063181415.5021.0.camel@laptop.fenrus.com>
References: <2739.195.80.106.123.1063183974.squirrel@mail.linking.ee>
        <1063181415.5021.0.camel@laptop.fenrus.com>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the same problem with vanilla 2.4.22 (SMP kernel on UP hw)

for example, after startup:

1. cp -dpR lotsfiles4GB /testcopy
2. load goes with minutes to 13
3. /bin/sync  blocks
4. Ctrl-Z to cp
5. ps axlef waits 3-10 secs before answer as raid1 sync goes with 14kB/sec

previous problem was without raid sync, currently just it takes time to
test without it
NB! the same copy from the same softraid partition to the same softraid
partition sucks a bit, but load does not grow steadily, remains 3changing raid1sync speed affects a bit the whole thing, but does not end it.

the same copy within serverraid partition is ok.

Currently I havent managed to get softdog into action, but behaviour is
still bad enough to call it a BUG.




> On Wed, 2003-09-10 at 10:52, elmer@linking.ee wrote:
>>  cp -dpR lotsfiles2GB /testcopy
>>
>>                     SMP x335   UP x335
>> serverraid-serverraid  OK          OK
>> softraid-softraid      OK          OK
>> softraid-serverraid    OK          OK
>> serverraid5E-softraid  SLEEPY       X
>> serverraid1E-softraid     X       PROBLEM
>>
>> it is redhat AS 2.4.9-25 kernel, SMP kernel for both.
>
> that kernel is very old and heavily patched; lkml is not the place to
> report problems, your Red Hat support contact is...



