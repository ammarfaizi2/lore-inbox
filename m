Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261449AbSIWVbh>; Mon, 23 Sep 2002 17:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbSIWVbG>; Mon, 23 Sep 2002 17:31:06 -0400
Received: from pc-80-195-34-180-ed.blueyonder.co.uk ([80.195.34.180]:32647
	"EHLO sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S261450AbSIWV3b>; Mon, 23 Sep 2002 17:29:31 -0400
Date: Mon, 23 Sep 2002 22:34:29 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Shawn Starr <spstarr@sh0n.net>
Cc: sct@redhat.com, akpm@digeo.com, Con Kolivas <conman@kolivas.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] EXT2 vs EXT3 System calls via oprofile using contest 0.34
Message-ID: <20020923223429.V11682@redhat.com>
References: <200209190142.58122.spstarr@sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209190142.58122.spstarr@sh0n.net>; from spstarr@sh0n.net on Thu, Sep 19, 2002 at 01:42:58AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 19, 2002 at 01:42:58AM -0400, Shawn Starr wrote:
 
> EXT3 kernel calls
> ==========
 
> Top 3:
> c013cf70 16380    4.51113     get_hash_table          /lib/modules/2.4.20-pre7-rmap14a-xfs-uml-shawn12d/build/vmlinux

Same as ext2...

> c016b090 22883    6.30209     do_get_write_access     /lib/modules/2.4.20-pre7-rmap14a-xfs-uml-shawn12d/build/vmlinux

That's an inevitable penalty from the way ext3 does journaling --- you
get two copies of data if a filesystem operation updates a block that
is still being journaled (because we need to snapshot the old copy to
write to the journal).  That's done when ext3 notifies an intent to
modify the old block, so all those copies show up in
do_get_write_access.

> c0164910 26375    7.2638      ext3_do_update_inode    /lib/modules/2.4.20-pre7-rmap14a-xfs-uml-shawn12d/build/vmlinux

I've got a fix for excessive CPU time spent here.

--Stephen
