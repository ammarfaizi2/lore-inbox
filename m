Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272665AbTHKOgR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272644AbTHKOgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 10:36:17 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:4841 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S272665AbTHKOgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 10:36:02 -0400
Date: Mon, 11 Aug 2003 07:35:31 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test3-mm1
Message-ID: <94490000.1060612530@[10.10.2.4]>
In-Reply-To: <20030809203943.3b925a0e.akpm@osdl.org>
References: <20030809203943.3b925a0e.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Andrew Morton <akpm@osdl.org> wrote (on Saturday, August 09, 2003 20:39:43 -0700):

> . This kernel immediately triplefaults when compiled with gcc-2.95.3 and
>   CONFIG_KGDB.  It is due to compiling with "-ggdb" or "-gdwarf-2".  When
>   compiled with "-g" it works OK, but gdb screws that up.
> 
>   Moral: use a later gcc if you're a kgdb user.

Well, on the upside, 2.95.4 (Debian Woody) seems to work fine, so you don't 
have to drown yourself in the pit of slow treacle. However, after printing
"kgdb <20030806.1101.35> : port =3f8, IRQ=4, divisor =1", it spews out 
garbage to the serial console (looks like 8-bit data or something).
I didn't enable it on the cmd line, just compiled it in ... does that 
trigger it for you?

-----

Degredation on kernbench is still there:

Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed      System        User         CPU
              2.6.0-test3       45.97      115.83      571.93     1494.50
          2.6.0-test3-mm1       46.43      122.78      571.87     1496.00

Quite a bit of extra sys time. I thought the suspected part of the sched
changes got backed out, but maybe I'm just not following it ...

------

4/4 split is still being wierd for me (same pattern as before). I think
it's just the rc script crapping out which causes the hostname not to
get set, or the rootfs to get remounted r/w.

M.

