Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbTDUUNg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 16:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbTDUUNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 16:13:35 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:47317 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261896AbTDUUNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 16:13:35 -0400
Message-ID: <3EA453BF.7030206@colorfullife.com>
Date: Mon, 21 Apr 2003 22:25:35 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Q: which archs differ between VERIFY_READ and VERIFY_WRITE in access_ok?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that access_ok receives a flag that specifies read or write 
access.
Do any archs rely on that flag, except 80386?

For example sys_poll contains:

>	if (copy_from_user(pp->entries, ufds + nfds-i, 
>				sizeof(struct pollfd)*pp->len)) {
>			err = -EFAULT;
>			goto out_fds;
>		}
>		i -= pp->len;
>  
>
[snip: code that allocates memory, sleep until data is around, ...]

>			if(__put_user(fds[j].revents, &ufds->revents))
>				goto out_fds;
>  
>
If an arch really treats VERIFY_READ differently that VERIFY_WRITE, then 
this would be wrong.

Are there ports that perform some checks only for VERIFY_WRITE? I have a 
fix for 80386.

--
    Manfred

