Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135509AbRAJNMy>; Wed, 10 Jan 2001 08:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135526AbRAJNMp>; Wed, 10 Jan 2001 08:12:45 -0500
Received: from mailout1-1.nyroc.rr.com ([24.92.226.146]:46538 "EHLO
	mailout1-1.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S135509AbRAJNMk>; Wed, 10 Jan 2001 08:12:40 -0500
Date: Wed, 10 Jan 2001 08:08:44 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] major security bug in reiserfs (may affect SuSE Linux)
Message-ID: <20010110080844.C8077@rochester.rr.com>
In-Reply-To: <20010110004201.A308@cerebro.laendle> <3A5BB340.9EA8B5C3@namesys.botik.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5BB340.9EA8B5C3@namesys.botik.ru>; from vs@namesys.botik.ru on Wed, Jan 10, 2001 at 03:56:32AM +0300
From: Gnea <gnea@rochester.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 03:56:32AM +0300, Vladimir V. Saveliev wrote:
> Hi
> 
> Marc Lehmann wrote:
> 
> > We are still investigating, but there seems to be a major security problem
> 
> Hmm,
> mkdir "$(perl -e 'print "x" x 768')"
> ls
> echo *
> 
> works here as it should. (2.2.18 and reiserfs-3.5.29)

 cat /proc/version
 Linux version 2.4.0-test11 (root@celery) (gcc version 2.95.2 20000220
 (Debian GNU/Linux)) #1 SMP Fri Dec 15 01:45:43 EST 2000

snipping from dmesg:
reiserfs: checking transaction log (device 21:08) ...
Using tea hash to sort names
ReiserFS version 3.6.22

while mkdir "$(perl -e 'print "x" x 768')" works just fine, doing a
mkdir "$(perl -e 'print "x" x 4000')" will create the dir, but will NOT
segfault any program, NOR cause a kernel oops.. howeever, it will NOT
show up with ls.  rm -rf "$(perl -e 'print "x" x 4000')" _will_ work...
i have yet to experience any crashes, segfaults or oopses since.

-- 
    .oO Gnea [gnea at rochester dot rr dot com] Oo.
         .oO url: http://garson.org/~gnea Oo.

"You can tune a filesystem, but you can't tuna fish." -unknown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
