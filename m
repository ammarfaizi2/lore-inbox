Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129381AbRBUXwB>; Wed, 21 Feb 2001 18:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129693AbRBUXvw>; Wed, 21 Feb 2001 18:51:52 -0500
Received: from dns-229.dhcp-248.nai.com ([161.69.248.229]:58835 "HELO
	localdomain") by vger.kernel.org with SMTP id <S129381AbRBUXvT>;
	Wed, 21 Feb 2001 18:51:19 -0500
Message-ID: <XFMail.20010221155213.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3A945272.F13610AB@innominate.de>
Date: Wed, 21 Feb 2001 15:52:13 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
To: Daniel Phillips <phillips@innominate.de>
Subject: Re: [rfc] Near-constant time directory index for Ext2
Cc: Martin Mares <mj@suse.cz>, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 21-Feb-2001 Daniel Phillips wrote:
> "H. Peter Anvin" wrote:
>> 
>> Martin Mares wrote:
>> >
>> > > True.  Note too, though, that on a filesystem (which we are, after all,
>> > > talking about), if you assume a large linear space you have to create a
>> > > file, which means you need to multiply the cost of all random-access
>> > > operations with O(log n).
>> >
>> > One could avoid this, but it would mean designing the whole filesystem in
>> > a
>> > completely different way -- merge all directories to a single gigantic
>> > hash table and use (directory ID,file name) as a key, but we were
>> > originally
>> > talking about extending ext2, so such massive changes are out of question
>> > and your log n access argument is right.
>> 
>> It would still be tricky since you have to have actual files in the
>> filesystem as well.
> 
> Have you looked at the structure and algorithms I'm using?  I would not
> call this a hash table, nor is it a btree.  It's a 'hash-keyed
> uniform-depth tree'.  It never needs to be rehashed (though it might be
> worthwhile compacting it at some point).  It also never needs to be
> rebalanced - it's only two levels deep for up to 50 million files.
> 
> This thing deserves a name of its own.  I call it an 'htree'.  The
> performance should speak for itself - 150 usec/create across 90,000
> files and still a few optmizations to go.
> 
> Random access runs at similar speeds too, it's not just taking advantage
> of a long sequence of insertions into the same directory.
> 
> BTW, the discussion in this thread has been very interesting, it just
> isn't entirely relevant to my patch :-)

Daniel,

I'm all but saying that Your algo is not good.
I use something very like to it in my mail server ( XMail ) to index mail queue
files that has a two level depth fs splitting.
The mine was only an hint to try different types of directory indexing.



- Davide

