Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281214AbSAPRTg>; Wed, 16 Jan 2002 12:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280588AbSAPRT2>; Wed, 16 Jan 2002 12:19:28 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:49344 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S281809AbSAPRTO>; Wed, 16 Jan 2002 12:19:14 -0500
To: Ben Clifford <benc@hawaga.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE][PATCH] New fs to control access to system resources
In-Reply-To: <Pine.LNX.4.33.0201151409270.1744-100000@barbarella.hawaga.org.uk>
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: 16 Jan 2002 18:18:50 +0100
Message-ID: <87vge2jjt1.fsf@tigram.bogus.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

I just managed to build and boot 2.5.2 plus my patch. My named starts
without any problem. So, sorry can't reproduce it here.

Ben Clifford <benc@hawaga.org.uk> writes:

> After applying your patch to 2.5.2, my named wouldn't start up (it
> couldn't bind to port 921)

This sounds weird. Normally, named binds to port 53 and some high
unprivileged port for replies from other DNS servers. Do you have some
'listen-on' and/or 'query-source' statements in your named.conf? If
you do, just change permissions of /mnt/net/ipv4/bind/921 appropriately.

> The below patch seems to have fixed that, and I think is probably the
> right thing to do.
[...]
> -	if (snum && snum < PROT_SOCK && !accessfs_permitted(&bind_to_port[snum], MAY_EXEC))
> +	if (snum && snum < PROT_SOCK && !accessfs_permitted(&bind_to_port[snum], MAY_EXEC) && !capable(CAP_NET_BIND_SERVICE))

You may use accessfs and capabilities in parallel, of course. But
currently, this is equivalent to "chown root/chmod u+x".

Regards, Olaf.
