Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274437AbRITMGV>; Thu, 20 Sep 2001 08:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274438AbRITMGM>; Thu, 20 Sep 2001 08:06:12 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:7432 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S274437AbRITMFw>;
	Thu, 20 Sep 2001 08:05:52 -0400
Date: Thu, 20 Sep 2001 09:06:01 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Rob Fuller <rfuller@nsisoftware.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <20010920112110Z16256-2757+869@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0109200903100.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001, Daniel Phillips wrote:
> On September 20, 2001 12:04 am, Alan Cox wrote:
> > Reverse mappings make linear aging easier to do but are not critical (we
> > can walk all physical pages via the page map array).
>
> But you can't pick up the referenced bit that way, so no up aging,
> only down.

That still doesn't mean we can't _approximate_ aging in
another way. With linear page aging (3 up, 1 down) the
page ages of pages referenced only in the page tables
will still go up, albeit a tad slower than expected.

It's exponential aging which makes the page age go into
the other direction, with linear aging things seem to
work again.

I've done some experiments recently and found that (with
reverse mappings) exponential aging is faster when we have
a small inactive list and linear aging is faster when we
have a large inactive list.

This means we need linear page aging with a large inactive
list in order to let the page ages move into the right
direction when we run a system without reverse mapping,
the patch for that was sent to Alan yesterday.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

