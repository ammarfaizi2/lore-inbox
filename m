Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262966AbTCNLo7>; Fri, 14 Mar 2003 06:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262976AbTCNLo7>; Fri, 14 Mar 2003 06:44:59 -0500
Received: from packet.digeo.com ([12.110.80.53]:10483 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262966AbTCNLo4>;
	Fri, 14 Mar 2003 06:44:56 -0500
Date: Fri, 14 Mar 2003 03:55:32 -0800
From: Andrew Morton <akpm@digeo.com>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.64-mm6
Message-Id: <20030314035532.3fb6e351.akpm@digeo.com>
In-Reply-To: <87bs0eqors.fsf@lapper.ihatent.com>
References: <20030313032615.7ca491d6.akpm@digeo.com>
	<87bs0eqors.fsf@lapper.ihatent.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Mar 2003 11:55:32.0850 (UTC) FILETIME=[9DE24520:01C2EA20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Hoogerhuis <alexh@ihatent.com> wrote:
>
> I've used tried the -mm-kernels since they've actually made
> 2.5-kernels usable on my laptop lately (Compaq Evo800c), but
> 2.5.64-mm2 and onwards doesnt work with X anymore. I run 4.3.0-r1 from
> the Gentoo unstable "branch".
> 
> with -mm1 I X coming up just nicely, and now the screen just goes
> black after trying to start X, and it seems related to DRM.

I have a radeon card here.  Just tried it.  The X server starts up OK but as
soon as I run tuxracer, some ioctl down in the radeon driver keeps on timing
out waiting for the FIFO, spins for ten milliseconds in-kernel and the X
server immediately calls the ioctl again.  The whole thing is bust.  I went
all the way back to 2.5.39, where it is still bust.  2.4.21-pre5 is OK
though.

So it looks like my breakage is different from yours.

Could you please try just 2.5.64 plus
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.64/2.5.64-mm6/broken-out/linus.patch

That will tell us if it is a -mm bug or a -linus bug.

It it is the latter, and if you're feeling really keen then could you search through the patches at 
http://www.zip.com.au/~akpm/linux/patches/2.5/badari/
and work out exactly which one introduced the problem?

Each of those patches is against 2.5.64.   The chronological order is:

cset-1.1085-to-1.1085.txt.gz
cset-1.1085-to-1.1086.txt.gz
cset-1.1085-to-1.1089.txt.gz
cset-1.1085-to-1.1090.txt.gz
cset-1.1085-to-1.1091.txt.gz
cset-1.1085-to-1.1094.txt.gz
cset-1.1068.1.17-to-1.1075.txt.gz
cset-1.1068.1.17-to-1.1077.txt.gz
cset-1.1068.1.17-to-1.1106.txt.gz
cset-1.1068.1.17-to-1.1107.txt.gz
cset-1.1068.1.17-to-1.1110.txt.gz
cset-1.1068.1.17-to-1.1122.txt.gz
cset-1.1068.1.17-to-1.1123.txt.gz
cset-1.1068.1.17-to-1.1124.txt.gz
cset-1.1068.1.17-to-1.1125.txt.gz
cset-1.1068.1.17-to-1.1127.txt.gz
cset-1.1068.1.17-to-1.1131.txt.gz
cset-1.1068.1.17-to-1.1137.txt.gz
cset-1.1068.1.17-to-1.1160.txt.gz
cset-1.1068.1.17-to-1.1166.txt.gz
cset-1.1068.1.17-to-1.1168.txt.gz
cset-1.1068.1.17-to-1.1171.txt.gz
cset-1.1068.1.17-to-1.1173.txt.gz
cset-1.1068.1.17-to-1.1174.txt.gz
cset-1.1068.1.17-to-1.1175.txt.gz
cset-1.1068.1.17-to-1.1177.txt.gz
cset-1.1068.1.17-to-1.1101.txt.gz
cset-1.1068.1.17-to-1.1113.txt.gz
cset-1.1068.1.17-to-1.1119.txt.gz
cset-1.1068.1.17-to-1.1147.txt.gz
cset-1.1068.1.17-to-1.1154.txt.gz
cset-1.1068.1.17-to-1.1157.txt.gz

Thanks.
