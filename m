Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289358AbSAOCg5>; Mon, 14 Jan 2002 21:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289367AbSAOCgs>; Mon, 14 Jan 2002 21:36:48 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:29852 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289358AbSAOCgn>; Mon, 14 Jan 2002 21:36:43 -0500
Date: Mon, 14 Jan 2002 21:36:41 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org
Subject: Re: Penelope builds a kernel
Message-ID: <20020114213641.I30639@redhat.com>
In-Reply-To: <20020114165909.A20808@thyrsus.com> <20020114173542.C30639@redhat.com> <20020114173854.C23081@thyrsus.com> <20020114180007.D30639@redhat.com> <20020114180522.A24120@thyrsus.com> <20020114183820.G30639@redhat.com> <20020114205307.E24120@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020114205307.E24120@thyrsus.com>; from esr@thyrsus.com on Mon, Jan 14, 2002 at 08:53:07PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 08:53:07PM -0500, Eric S. Raymond wrote:
> I don't understand what you think you're seeing, but I am sure of
> this; if I had been enough of a drug-addled lunatic to allow fetchmail
> to delete mail before getting a positive acknowledge from the
> downstream MTA, someone in the pool of over two thousand people who have sent
> me bug reports and patches would have called me on it some time in the
> six years of production use well before *you* entered the picture.

Uhm, as someone who has run a number of mailing lists for the past 6 
years, I've seen fetchmail induced bounces numerous times, and 99% of 
the time they're because the damn thing should default to a 
--never-send-bounces-to-anyone.

> It's likely you're being hosed by an MTA that's sending back bogus 2xx
> responses.  That's happend before.  Fetchmail can't magically cope
> with MTAs that tell it lies.

That's part of what you have to deal with by being a hybrid MTA/MUA: 
your error handling must be directed at the user of fetchmail, not the 
originator of the message.  The originator of the message has no control 
over the misdelivery of the message due to user config file error, so 
why should they receive the error?  Bounces like these are very 
difficult to determine what the address causing trouble is because of 
the fact that fetchmail *is* an MUA -> it should not behave as if it is 
purely an MTA.

> Fetchmail *already works the way you recommend* -- as any idiot can
> verify by reading the short section of the main driver loop where
> dispatch and delete takes place.  That's been an invariant of the code
> since day one, and you thus clearly have no bloody idea what you are
> flaming about.

Good, at least that part of my understanding of it was wrong, and I'm 
glad to hear that.  But the behaviour is still indistinguishable from 
the gross misdesign that it feels like.  Namely, ask yourself why it 
loses mail if the user makes a typo in the config file on their first 
try?  Who gets the bounce?  Why should the message be deleted instead 
of merely deferred?

Besides, I think you're trying to solve the wrong problem.  A good many 
readers of linux-kernel don't want to start seeing posts from Aunt Tillie 
and would rather leave this ease of use issue to the distributions that 
already make it easy as pie.

		-ben
