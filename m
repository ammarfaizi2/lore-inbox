Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274237AbRISWfj>; Wed, 19 Sep 2001 18:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274235AbRISWfa>; Wed, 19 Sep 2001 18:35:30 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:61446 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S274237AbRISWfL>; Wed, 19 Sep 2001 18:35:11 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Date: Thu, 20 Sep 2001 08:35:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15273.7576.395258.345452@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Define conflict between ext3 and raid patches against 2.2.19
In-Reply-To: message from Mike Fedyk on Wednesday September 19
In-Reply-To: <20010916155835.C24067@mikef-linux.matchmail.com>
	<15271.11056.810538.66237@notabene.cse.unsw.edu.au>
	<20010919133811.B22773@mikef-linux.matchmail.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday September 19, mfedyk@matchmail.com wrote:
> On Tue, Sep 18, 2001 at 09:08:32PM +1000, Neil Brown wrote:
> > 
> > You should be aware that ext3 (and other journalling filesystems) do
> > not work reliably over RAID1 or RAID5 in 2.2.  Inparticular, you can
> > get problems when the array is rebuilding/resyncing.
> > 
> > But if you only plan to use ext3 with raid0 or linear, you should be
> > fine.
> > 
> 
> Can you point me to an archive that describes how to trigger this bug?
> 
> Was it in linux-raid or ext3-users or ...?
> 
> Mike

I don't remember exactly where or when I read it - either linux-raid
or linux-kernel.  It was asserted by Stephen Tweedie.

The problem is that ext3 is very careful about when it writes buffer
to disk : it won't release a buffer until the relevant journal entry
is committed.

However when a RAID rebuild happens, every block on the array is read
into the buffer cache (if it isn't already there) and then written
back out again.  This defeats the control that ext3 tries to maintain
on the buffer cache.

I don't know exactly what large-scale effects this might have.  It
could be simply that a crash at the wrong time could leave the
filesystem corrupted.  But I heard of one person who claimed to get
filesystem corruption after using reiserfs over RAID1 in 2.2, so maybe
it's worse than that.

If you really need to know, I suggest you ask on ext3-users. 

NeilBrown
