Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbTLUSsx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 13:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTLUSsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 13:48:53 -0500
Received: from ping.ovh.net ([213.186.33.13]:21220 "EHLO ping.ovh.net")
	by vger.kernel.org with ESMTP id S263646AbTLUSsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 13:48:51 -0500
Date: Sun, 21 Dec 2003 19:47:09 +0100
From: Octave <oles@ovh.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lot of VM problem with 2.4.23
Message-ID: <20031221184709.GO25043@ovh.net>
References: <20031221001422.GD25043@ovh.net> <1071999003.2156.89.camel@abyss.local> <Pine.LNX.4.58L.0312211235010.6632@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0312211235010.6632@logos.cnet>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How much swap do you have in your system?
> 
> This is happening because the system is unable to free memory (you
> probably ran out of swap for some reason).

Marcelo,
You can run this easy script. 2.4.19 takes about 30 minutes 
to kill all process. 2.4.23 takes about 60 minutes.

I think, server crashs when VM kills a process like watchdog (why ?).

Octave

# head -n 100000 /dev/urandom > file
# cat > full.pl
#!/usr/bin/perl

open (F,"file");@F=<F>;close(F);
for (;;) { push @F,@F; }
# chmod 755 full.pl
# for i in `seq 1 100`; do ./full.pl &  done
[1] 767
[2] 768
[3] 769
[4] 770
[5] 771
[...]


# tail -f /var/log/messages
Dec 21 18:55:32 stock kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Dec 21 18:55:32 stock kernel: VM: killing process full.pl
Dec 21 18:55:37 stock kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Dec 21 18:55:37 stock kernel: VM: killing process full.pl


