Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131486AbRCXCA3>; Fri, 23 Mar 2001 21:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131544AbRCXCAJ>; Fri, 23 Mar 2001 21:00:09 -0500
Received: from hibernia.clubi.ie ([212.17.32.129]:19356 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S131486AbRCXCAE>; Fri, 23 Mar 2001 21:00:04 -0500
Date: Sat, 24 Mar 2001 01:59:53 +0000 (GMT)
From: Paul Jakma <paul@jakma.org>
To: <Andries.Brouwer@cwi.nl>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <UTC200103232315.AAA07966.aeb@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.33.0103240149570.11627-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Mar 2001 Andries.Brouwer@cwi.nl wrote:

> No, ulimit does not work. (But it helps a little.)

no, not perfect, i very much agree. but in daily usage it reduces
chance of OOM to close to 0.

> No, /proc/sys/vm/overcommit_memory does not work.

that's because it disables the very rough resource checking that
linux has. it makes OOM even easier to achieve:

mm/mmap.c::vm_enough_memory():

	/* Sometimes we want to use more memory than we have. */
        if (sysctl_overcommit_memory)
            return 1;

it doesn't make linux go into a 'non-overcommit' mode, cause linux
does not have the accounting to cover it...

solution according to more knowledgable folks than i, sysadmin, is
better accounting so that vm_enough_memory can be more accurate
rather than developing an all-seeing oom_killer().

> Andries

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
"We are on the verge: Today our program proved Fermat's next-to-last theorem."
		-- Epigrams in Programming, ACM SIGPLAN Sept. 1982

