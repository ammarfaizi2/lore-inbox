Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUERAqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUERAqb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 20:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUERAqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 20:46:31 -0400
Received: from taco.zianet.com ([216.234.192.159]:64008 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S261405AbUERAq3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 20:46:29 -0400
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Date: Mon, 17 May 2004 18:45:43 -0600
User-Agent: KMail/1.6.1
Cc: mason@suse.com, torvalds@osdl.org, lm@bitmover.com, wli@holomorphy.com,
       hugh@veritas.com, adi@bitmover.com, support@bitmover.com,
       linux-kernel@vger.kernel.org
References: <200405132232.01484.elenstev@mesatop.com> <200405171752.08400.elenstev@mesatop.com> <20040517171330.7d594eb1.akpm@osdl.org>
In-Reply-To: <20040517171330.7d594eb1.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405171845.44973.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 May 2004 06:13 pm, Andrew Morton wrote:
> Steven Cole <elenstev@mesatop.com> wrote:
> >
> > > 
> > OK, applied your one-liner above with PREEMPT.
> > 
> > ...
> > Found null start 0xfb259a end 0xfb3000 len 0xa66 line 478846
> > 
> > The above was on reiserfs and happened on the very first pull.
> > 
> > Attaching the source of saga.c for reference.
> 
> ok, thanks.
> 
> > So, what next doc?  Back out that one-liner and try your vmtruncate?
> 
> No, it won't help in that case.
> 
> > Or try Chris' patch for reiserfs?
> > 
> > At the moment I'm testing on ext3, which survived the two pull/unpulls.  
> > This is like watching paint dry.
> > 
> > I'll do some more bk unpull and bk pull cycles until this breaks on ext3.
> 
> I guess it would be interesting to run it on a filesystem which has 2k or
> even 1k blocksize.  If the corruption then terminates on a 2k- or
> 1k-boundary then that will rule out a few culprits.
> 
> I'd really like to see this happen on some other machine though.  It'd be
> funny if you have a dud disk drive or something.
> 
> 
I have a backup disk as /dev/hdb, which is usually not mounted.

[root@spc steven]# df -T
Filesystem    Type    Size  Used Avail Use% Mounted on
/dev/hda6     ext3    293M   88M  190M  32% /
/dev/hda9 reiserfs     26G  8.3G   18G  32% /home
/dev/hda1     ntfs    3.0G  2.4G  651M  79% /mnt/win_c
/dev/hda5     vfat    3.0G  811M  2.2G  27% /mnt/win_d
/dev/hda7     ext3    3.9G  2.1G  1.7G  56% /usr
/dev/hda8     ext3    491M   69M  397M  15% /var
/dev/hdb1 reiserfs    299M  180M  119M  61% /home/steven/red
/dev/hdb6 reiserfs    3.9G  1.8G  2.2G  46% /home/steven/blue
/dev/hdb7 reiserfs    299M  175M  124M  59% /home/steven/green
/dev/hdb8 reiserfs    197M   38M  159M  19% /home/steven/yellow
/dev/hdb9 reiserfs     12G  5.4G  5.8G  48% /home/steven/purple

I could possibly reformat /dev/hdb6 (3.9G) for testing later.
Let me know the details on what would be most meaningfull.

The ext3 fs (/usr) has survived four cycles of 
bk pull bk://linux.bkbits.net/linux-2.5
bk unpull -fq

Steven
