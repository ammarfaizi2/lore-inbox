Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275552AbRJAVRr>; Mon, 1 Oct 2001 17:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275548AbRJAVRm>; Mon, 1 Oct 2001 17:17:42 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:37380 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S275552AbRJAVRb>; Mon, 1 Oct 2001 17:17:31 -0400
Message-ID: <3BB8DD83.96B9220F@namesys.com>
Date: Tue, 02 Oct 2001 01:17:55 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Define conflict between ext3 and raid patches against 2.2.19
In-Reply-To: <20010916155835.C24067@mikef-linux.matchmail.com>
			<15271.11056.810538.66237@notabene.cse.unsw.edu.au>
			<20010919133811.B22773@mikef-linux.matchmail.com> <15273.7576.395258.345452@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More precisely, as long as you understand that resync requires doing the resync
offline,  and
accept that, and remember it, and your colleagues at work remember it:-), you
can use it.  Personally, I would just go to 2.4 myself.

Hans


Neil Brown wrote:
> 
> On Wednesday September 19, mfedyk@matchmail.com wrote:
> > On Tue, Sep 18, 2001 at 09:08:32PM +1000, Neil Brown wrote:
> > >
> > > You should be aware that ext3 (and other journalling filesystems) do
> > > not work reliably over RAID1 or RAID5 in 2.2.  Inparticular, you can
> > > get problems when the array is rebuilding/resyncing.
> > >
> > > But if you only plan to use ext3 with raid0 or linear, you should be
> > > fine.
> > >
> >
> > Can you point me to an archive that describes how to trigger this bug?
> >
> > Was it in linux-raid or ext3-users or ...?
> >
> > Mike
> 
> I don't remember exactly where or when I read it - either linux-raid
> or linux-kernel.  It was asserted by Stephen Tweedie.
> 
> The problem is that ext3 is very careful about when it writes buffer
> to disk : it won't release a buffer until the relevant journal entry
> is committed.
> 
> However when a RAID rebuild happens, every block on the array is read
> into the buffer cache (if it isn't already there) and then written
> back out again.  This defeats the control that ext3 tries to maintain
> on the buffer cache.
> 
> I don't know exactly what large-scale effects this might have.  It
> could be simply that a crash at the wrong time could leave the
> filesystem corrupted.  But I heard of one person who claimed to get
> filesystem corruption after using reiserfs over RAID1 in 2.2, so maybe
> it's worse than that.
> 
> If you really need to know, I suggest you ask on ext3-users.
> 
> NeilBrown
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
