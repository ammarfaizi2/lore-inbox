Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129858AbQKOLd1>; Wed, 15 Nov 2000 06:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130127AbQKOLdR>; Wed, 15 Nov 2000 06:33:17 -0500
Received: from quechua.inka.de ([212.227.14.2]:57888 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129858AbQKOLdJ>;
	Wed, 15 Nov 2000 06:33:09 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: More modutils: It's probably worse.
In-Reply-To: <8us4ji$dbl$1@cesium.transmeta.com> <11900.974244463@ocs3.ocs-net>
Organization: private Linux site, southern Germany
Date: Wed, 15 Nov 2000 11:43:54 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E13w02k-000172-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The original exploit had nothing to do with filenames masquerading as
> options, it was: ping6 -I ';chmod o+w .'.  Then somebody pointed out

Why is there any reason that a shell should be invoked anywhere in the
request_module->modprobe->insmod chain?
If implemented correctly, this attack should have the same result as
insmod ';chmod o+w .' (and it should not matter if it gets renamed so
that the actual command executed is insmod 'netdevice-;chmod o+w .')

> The problem is the combination of kernel code passing user space
> parameters through unchanged (promoting user input to root)

Which means that all parts of the chain which deal with possible user
input in elevated privilege mode must do input validation. This means
the kernel _and_ modprobe in my book.

> plus the
> modprobe meta expansion algorithm.

and I see no reason why modprobe should do any such thing, apart from
configurations dealt with in modules.conf anyway.

Olaf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
