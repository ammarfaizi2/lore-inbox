Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbWGKCSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbWGKCSh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 22:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbWGKCSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 22:18:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:53392 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965078AbWGKCSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 22:18:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QEeDecoaXpg0sCovR9Dae3AF5/8q5d3oUeduLJ1UkE+3mIygTzeD/8kQgjSuDvxu9QogWlyfp3BNyTmqIZoYbg7sIKymHKaumdpD3yixAEdeG527OUwtvOXOHOcQY1XVUfeQAdX6DxPyGBmTiL6xXeiR0solLPbg0n6QZxzncrA=
Message-ID: <787b0d920607101918q6e1d77e8r22d998a820670dbd@mail.gmail.com>
Date: Mon, 10 Jul 2006 22:18:35 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: jonsmirl@gmail.com, alan@lxorguk.ukuu.org.uk, hpa@zytor.com,
       greg@kroah.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Clean up old names in tty code to current names
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl writes:

> If I use udev to rename my devices, the names aren't going
> to match /proc/tty and what ps shows.

It's not as if ps will mislead you. You get "?" if you
redirected stderr or if you lack permission to examine
the /proc/*/fd/* links.

Of course, failing to follow Documentation/devices.txt is
complete foolishness. We have standards you know. The names
are pretty much part of the ABI. Feel free to swap /dev/zero
with /dev/random if you believe otherwise.

> The idea behind udev is that the kernel only deals in device
> numbers and all naming happens in user space.

For many things, the kernel knows:

$ cat /proc/*/maps | egrep '000[ ].*/dev'
3001e000-30020000 rw-s 90000000 03:0d 2989877    /dev/fb0
3002a000-3004a000 rw-s f0000000 03:0d 2990830    /dev/mem
3004a000-3104a000 rw-s 94000000 03:0d 2989877    /dev/fb0

The kernel only needs to remember, by keeping a dentry around.

Not that a devices.txt-compliant devfs wouldn't kick ass...
