Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269112AbRHBU0c>; Thu, 2 Aug 2001 16:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269115AbRHBU0W>; Thu, 2 Aug 2001 16:26:22 -0400
Received: from hera.cwi.nl ([192.16.191.8]:28088 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S269112AbRHBU0I>;
	Thu, 2 Aug 2001 16:26:08 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 2 Aug 2001 20:25:42 GMT
Message-Id: <200108022025.UAA114868@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] vxfs fix
Cc: hch@caldera.de, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Let me try again

OK - now I see what you mean, but I think you misunderstand.
The system call mount(2) has an obligatory parameter "type".
The kernel never guesses.

[Apart from the situation at boot time, where it knows the
device and guesses the type. This is bad, and I hope it
will go away. Some types are very difficult to distinguish.]

So, the kernel only does what it is told.

But mount(8) has users, and they are a lazy bunch.
Instead of saying "mount -t iso9660 image /mnt -o loop,ro"
they type "mount image /mnt" and hope that mount(8) can
figure out the rest. And mount(8) knows about the magic numbers
of a handful of filesystems, and if one of these is recognized
it will try that type. Otherwise it will just try all remaining
types in /proc/filesystems. It is this guessing that leads to
crashes in case the kernel succeeds in mounting garbage.

Andries

