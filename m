Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130194AbRANTLK>; Sun, 14 Jan 2001 14:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131428AbRANTLA>; Sun, 14 Jan 2001 14:11:00 -0500
Received: from chiara.elte.hu ([157.181.150.200]:9488 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130194AbRANTKj>;
	Sun, 14 Jan 2001 14:10:39 -0500
Date: Sun, 14 Jan 2001 20:09:54 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: jamal <hadi@cyberus.ca>
Cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.GSO.4.30.0101141356050.12354-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.30.0101142006420.3610-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 14 Jan 2001, jamal wrote:

> Already doing the single file, single process. [...]

in this case there could still be valid performance differences, as
copying from user-space is cheaper than copying from the pagecache. To
rule out SMP interactions, you could try a UP-IOAPIC kernel on that box.

(I'm also curious what kind of numbers you'll get with the zerocopy
patch.)

> However, i do run by time which means i could read the file from the
> begining(offset 0) to the end then re-do it for as many times as
> 15secs would allow. Does this affect it? [...]

no, in the case of a single thread this should have minimum impact. But
i'd suggest to increase the /proc/sys/net/tcp*mem* values (to 1MB or
more).

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
