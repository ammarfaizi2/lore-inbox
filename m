Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265111AbTLCUJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265145AbTLCUJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:09:39 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:26000 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S265111AbTLCUJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 15:09:23 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@osdl.org>
Date: Thu, 4 Dec 2003 07:09:10 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16334.17126.154718.614827@notabene.cse.unsw.edu.au>
Cc: Jens Axboe <axboe@suse.de>,
       David =?iso-8859-1?Q?Mart=EDnez?= Moreno <ender@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clubinfo.servers@adi.uam.es, Ingo Molnar <mingo@elte.hu>
Subject: Re: Errors and later panics in 2.6.0-test11.
In-Reply-To: message from Linus Torvalds on Wednesday December 3
References: <200312031417.18462.ender@debian.org>
	<Pine.LNX.4.58.0312030757120.5258@home.osdl.org>
	<20031203162045.GA27964@suse.de>
	<Pine.LNX.4.58.0312030823010.5258@home.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday December 3, torvalds@osdl.org wrote:
> 
> 
> On Wed, 3 Dec 2003, Jens Axboe wrote:
> > >
> > > Interesting. Another RAID 0 problem report..
> >
> > Hmm did _all_ reports include raid-0, or just "some" raid? I'm looking
> > at the bio_pair stuff which raid-0 is the only user of, something looks
> > fishy there.
> 
> The ones I've seen seem to be raid-0, but Nathan (nathans@sgi.com)
> reported problems in RAID-5 under load. I didn't decode the full oops on
> that one, but it really looked like a stale "bi" bio that trapped on the
> PAGE_ALLOC debug code.
> 

Nathan's had a second oops that turned out to be a bi_next pointer
being bad in a bio that raid5 had just about finished writing out.
So there does seem to be something wrong with bio handling, quite
possibly in raid5.

The only thing I could find was that if raid5 received two overlapping
bios concurrently (or atleast received the second before it had
finished with the first) it could get confused.  I've asked Nathan to
try a patch that BUGs when that happens.

NeilBrown
