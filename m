Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVJKOxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVJKOxr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 10:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbVJKOxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 10:53:46 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:51924 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S932107AbVJKOxp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 10:53:45 -0400
Message-ID: <434BD1FB.7070608@gmail.com>
Date: Tue, 11 Oct 2005 16:53:47 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Grzegorz Nosek <grzegorz.nosek@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: sys_sendfile oops in 2.6.13?
References: <121a28810510110156q1369b9dg@mail.gmail.com>
In-Reply-To: <121a28810510110156q1369b9dg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.51.171
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Nosek napsal(a):

>Hi all
>
>I found an (IMHO) silly bug in do_sendfile in 2.6.13.x kernels (at
>least in 2.6.13.3 and .4, didn't backtrack to find where it
>originated). Without the patch all I apparently get from sys_sendfile
>is an oops due to a call in sys_sendfile with ppos being NULL. With the
>patch it works OK. Noticed in vsftpd.
>
>The patch may apply with some fuzz as my kernel is somehwat patched but
>the gist of the patch is the same anyway
>
>Regards,
> Grzegorz Nosek
>
>--- linux-2.6/fs/read_write.c~  2005-10-06 21:35:03.000000000 +0200
>+++ linux-2.6/fs/read_write.c   2005-10-05 19:14:04.000000000 +0200
>@@ -719,7 +719,7 @@
>       current->syscr++;
>       current->syscw++;
>
>-       if (*ppos > max)
>+       if (ppos && *ppos > max)
>  
>
I don't know the code surrounding this, but shouldn't be this
(!ppos || *ppos > max)?

>               retval = -EOVERFLOW;
>
> fput_out:
>  
>
-- 
js

