Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVCQMfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVCQMfT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 07:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVCQMfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 07:35:19 -0500
Received: from port-212-202-144-146.static.qsc.de ([212.202.144.146]:44981
	"EHLO mail.hennerich.de") by vger.kernel.org with ESMTP
	id S261961AbVCQMfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 07:35:06 -0500
Date: Thu, 17 Mar 2005 13:30:26 +0100
From: Tobias Hennerich <Tobias@Hennerich.de>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: Timo Hennerich <Timo@Hennerich.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Vladimir Saveliev <vs@namesys.com>
Subject: Re: Strange memory leak in 2.6.x
Message-ID: <20050317133026.A4515@bart.hennerich.de>
References: <20050308173811.0cd767c3.akpm@osdl.org> <20050309102740.D3382@bart.hennerich.de> <20050311183207.A22397@bart.hennerich.de> <1110565420.2501.12.camel@boxen> <20050312133241.A11469@bart.hennerich.de> <1110640085.2376.22.camel@boxen> <20050312214216.A24046@bart.hennerich.de> <1110661479.3360.11.camel@boxen> <026101c52891$2a618410$0404010a@hennerich.de> <1110812292.2492.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <1110812292.2492.21.camel@localhost.localdomain>; from alexn@dsv.su.se on Mon, Mar 14, 2005 at 03:58:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Mar 14, 2005 at 03:58:12PM +0100, Alexander Nyberg wrote:
> > for one of the last results of /proc/page_owner. It seems to be
> > obvious that the memory-leak seems to be the first entry:
> > 
> >     $ less page_owner_sorted_20050314_0740.bz2
> >     881397 times:
> >     Page allocated via order 0
> >     [0xc013962b] find_or_create_page+91
> >     [0xf8aa9955] reiserfs_prepare_file_region_for_write+613
> >     [0xf8aaa606] reiserfs_file_write+1366
> >     [0xc015765c] vfs_write+172
> >     [0xc015776c] sys_write+60
> >     [0xc0103879] sysenter_past_esp+82
> 
> [resolved addresses => names]
> > 
> > The sorted table of /proc/kallsyms looks like this:
> > 
> >     f8aa96f0 t reiserfs_prepare_file_region_for_write       [reiserfs]
> >     f8aaa0b0 t reiserfs_file_write  [reiserfs]
> > 
> > So I guess that we have a problem with the reiser filesystem??
> > We are using reiserfs 3.6...
> 
> [added Vladimir Saveliev to CC]
> 
> The only thing that stands out is big page cache. However, looking at
> the previous OOM output it shows that it is zone normal that is
> completely out of memory and that highmem zone has lots of free memory.
> 
> Let's see if the big sharks know what is going on...

Hm, it seems like the big sharks are hunting other fishes at the moment...

I looked at the code myself - reiserfs_prepare_file_region_for_write
has more then 250 lines of code. I don't want to critize anyone, but
this function is a bit too long to be easily debugged.

Because we suspect the problem in reiserfs and we still have to reboot
the machine every other day, we will switch to ext3 now.

I will report if the problem disappears this way.

Best regards	Tobias

-- 
T+T Hennerich GmbH --- Zettachring 12a --- 70567 Stuttgart
Fon:+49(711)720714-0  Fax:+49(711)720714-44  Vanity:+49(700)HENNERICH
UNIX - Linux - Java - C  Entwicklung/Beratung/Betreuung/Schulung
http://www.hennerich.de/
