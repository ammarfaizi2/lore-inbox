Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130149AbRAQIKE>; Wed, 17 Jan 2001 03:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130270AbRAQIJz>; Wed, 17 Jan 2001 03:09:55 -0500
Received: from mailgate.att-unisource.net ([195.206.66.146]:12982 "HELO
	mailgate.eqip.net") by vger.kernel.org with SMTP id <S130149AbRAQIJj>;
	Wed, 17 Jan 2001 03:09:39 -0500
Path: Home.Lunix!not-for-mail
Subject: Re: Is sendfile all that sexy?
Date: Wed, 17 Jan 2001 08:09:35 +0000 (UTC)
Organization: lunix confusion services
In-Reply-To: <UTC200101161350.OAA141869.aeb@ark.cwi.nl>
    <943fm9$pjq$1@post.home.lunix>
    <14949.19028.404458.318735@tzadkiel.efn.org>
NNTP-Posting-Host: kali.eth
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: quasar.home.lunix 979718975 32091 10.253.0.3 (17 Jan 2001
    08:09:35 GMT)
X-Complaints-To: abuse-0@ton.iguana.be
NNTP-Posting-Date: Wed, 17 Jan 2001 08:09:35 +0000 (UTC)
X-Newsreader: knews 1.0b.0
Xref: Home.Lunix mail.linux.kernel:70000
X-Mailer: Perl5 Mail::Internet v1.32
Message-Id: <943jvv$var$1@post.home.lunix>
From: linux-kernel@ton.iguana.be (Ton Hospel)
To: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@ton.iguana.be (Ton Hospel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <14949.19028.404458.318735@tzadkiel.efn.org>,
	Steve VanDevender <stevev@efn.org> writes:
> Ton Hospel writes:
> > In article <UTC200101161350.OAA141869.aeb@ark.cwi.nl>,
> > 	Andries.Brouwer@cwi.nl writes:
> > > I am afraid I have missed most earlier messages in this thread.
> > > However, let me remark that the problem of assigning a
> > > file descriptor is the one that is usually described by
> > > "priority queue". The version of Peter van Emde Boas takes
> > > time O(loglog N) for both open() and close().
> > > Of course this is not meant to suggest that we use it.
> > > 
> > Fascinating ! But how is this possible ? What stops me from
> > using this algorithm from entering N values and extracting 
> > them again in order and so end up with a O(N*log log N)
> > sorting algorithm ? (which would be better than log N! ~ N*logN)
> > 
> > (at least the web pages I found about this seem to suggest you
> > can use this on any set with a full order relation)
> 
> How do you know how to extract the items in order, unless you've already
> sorted them independently from placing them in this data structure?

Because "extract max" is a basic operation of a priority queue,
which I just do N times.

> 
> Besides, there are plenty of sorting algorithms that work only on
> specific kinds of data sets that are better than the O(n log n) bound
> for generalized sorting.  For example, there's the O(n) "mailbox sort".
> You have an unordered array u of m integers, each in the range 1..n;
> allocate an array s of n integers initialized to all zeros, and for i in
> 1..m increment s[u[i]].  Then for j in 1..n print j s[j] times.  If n is
> of reasonable size then you can sort that list of integers in O(m) time.

Yes, I know. that's why you see the "any set with a full order relation"
in there. That basically disallows using extra structure of the elements.

Notice that the radix sort you describe basically hides the log N in the
the representation of a number of max n (which has a length that is
basically log n). It just doesn't account for that because we do the 
operation on processors where these bits are basically handled in parallel,
and so do not end up in the O-notation. Any attempt to make radix sort
handle arbitrary width integers on a fixed width processor will make the
log N reappear.

Having said that, in the particular case of fd allocation, we DO have
additional structure (in fact, it's indeed integers in 0..n). So I can
very well imagine the existance of a priority queue for this where the
basic operators are better than O(log N). I just don't understand how
it can exist for a generic priority queue algorithm (which the
Peter van Emde Boas method seems to be. Unfortunately I have found no
full description of the algorithm that's used to do the insert/extract
in the queue nodes yet).
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
