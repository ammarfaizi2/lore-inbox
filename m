Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268688AbRG3Wer>; Mon, 30 Jul 2001 18:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268691AbRG3Wei>; Mon, 30 Jul 2001 18:34:38 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:38925 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268688AbRG3Web>; Mon, 30 Jul 2001 18:34:31 -0400
Message-ID: <3B65E0FE.CC84FF98@namesys.com>
Date: Tue, 31 Jul 2001 02:34:38 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org,
        Vitaly Fertman <vitaly@namesys.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <Pine.LNX.4.33L.0107301858350.5582-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Rik van Riel wrote:
> 
> On Tue, 31 Jul 2001, Hans Reiser wrote:
> > Christoph Hellwig wrote:
> > >
> > > Nope.  It does a reiserfs_panic instead of letting the wrong arguments
> > > slipping into lower layers and possibly on disk and thus corrupting data.
> > >
> > > And in my opinion correct data is much more worth than one crash more or
> > > less (especially with a journaling filesystem).
> >
> > There is nothing like a distro maintainer overriding the design
> > decisions made by the lead architect of a package, not believing
> > that said architect knows what the fuck he is doing.
> 
> Are you actually saying you don't care about user's data,
> or is it just my imagination ?
> 
> (I hope it's my imagination ...)
> 
> cheers,
> 
> Rik
> --
> Executive summary of a recent Microsoft press release:
>    "we are concerned about the GNU General Public License (GPL)"
> 
>                 http://www.surriel.com/
> http://www.conectiva.com/       http://distro.conectiva.com/

I am saying that you can put so many internal checks into a filesytem that it is
unusable for any real usage.  Guess what?  ReiserFS does that!  But we surround
the checks with a #define.  The only limit we have on the checks, is that after
the relevant bug disappears we cut out the ones that make things so slow that it
noticeably inconveniences our debugging.  It has to slow things down quite a lot
that we can't stand to wait for it while debugging, but there are some kinds of
checks that you can do that are that slow.

ReiserFS checks more things than the rest of the kernel does.  We can do this
because we use the #define, and pay no price for it.  You should do this also in
your code....

Every major kernel component should have a #define which if on checks every
imaginable thing the developer can think of to check regardless of how slow it
makes the code go to check it.  Then, when users (or at least as usefully,
developers adding a new feature) have bugs in that component, they can turn it
on.

Hans
