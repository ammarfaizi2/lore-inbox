Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276483AbRJCQaW>; Wed, 3 Oct 2001 12:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276465AbRJCQaP>; Wed, 3 Oct 2001 12:30:15 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:52986 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S276486AbRJCQaC>; Wed, 3 Oct 2001 12:30:02 -0400
Date: Wed, 3 Oct 2001 17:30:16 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: lock_kiovec question
Message-ID: <20011003173016.C5209@redhat.com>
In-Reply-To: <3BB58FAF.D1AF2D25@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BB58FAF.D1AF2D25@colorfullife.com>; from manfred@colorfullife.com on Sat, Sep 29, 2001 at 11:09:03AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Sep 29, 2001 at 11:09:03AM +0200, Manfred Spraul wrote:
> lock_kiovec tries to lock each page in the kiovec, and fails if it can't
> lock one of the pages.
> 
> What if the zero page is mapped multiple times in the kiobuf?

Don't Do That then.  lock_kiobuf can be called if some caller really
wants the kiobuf pages locked, but kiobuf page mapping is much cleaner
in 2.4 than it had to be in 2.2 and there's no need to keep pages
locked during the mapping.  raw IO doesn't ever use lock_kiobuf in
2.4.

> AFAICS map_user_pages doesn't break zero page mappings if it's called
> with rw==WRITE (i.e write to disk, read from kiobuf)

Correct.  The raw IO code for 2.2 had to exempt zero pages from
locking for this reason.

Cheers,
 Stephen
