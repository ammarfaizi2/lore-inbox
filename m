Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318394AbSGaQ2Q>; Wed, 31 Jul 2002 12:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318399AbSGaQ2Q>; Wed, 31 Jul 2002 12:28:16 -0400
Received: from cse.ogi.edu ([129.95.20.2]:43495 "EHLO church.cse.ogi.edu")
	by vger.kernel.org with ESMTP id <S318394AbSGaQ2P>;
	Wed, 31 Jul 2002 12:28:15 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)
References: <20020730054111.GA1159@dualathlon.random>
	<20020730084939.A8978@redhat.com>
	<20020730214116.GN1181@dualathlon.random>
	<20020730175421.J10315@redhat.com>
	<20020731004451.GI1181@dualathlon.random>
From: "Charles 'Buck' Krasic" <krasic@acm.org>
Date: 31 Jul 2002 09:31:19 -0700
In-Reply-To: <20020731004451.GI1181@dualathlon.random>
Message-ID: <xu4bs8namg8.fsf@brittany.cse.ogi.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli <andrea@suse.de> writes:

> are you sure this is a good idea? this adds an implicit gettimeofday
> (thought no entry/exit kernel) to every getevents syscall with a
> "when" specificed, so the user may now need to do gettimeofday both
> externally and internally to use the previous "timeout" feature (given
> the kernel can delay only of a timeout, so the kernel has to calculate
> the timeout internally now). I guess I prefer the previous version that
> had the "timeout" information instead of "when". Also many soft
> multimedia only expect the timeout to take "timeout", and if a frame
> skips they'll just slowdown the frame rate, so they won't be real time
> but you'll see something on the screen/audio. Otherwise they can keep
> timing out endlessy if they cannot keep up with the stream, and they
> will show nothing rather than showing a low frame rate.

I disagree.  If for some reason the multimedia player can not keep up,
there will be corresponding changes to subsequent requested timeouts.
For example, the pattern of future timeouts will reflect the new lower
frame rate (e.g. timeout after 1/15 s instead of 1/30 s).  (BTW: I've
written adaptive media players, so I'm speaking from experience).

How repulsive would it be to add a boolean parameter that indicates
whether the supplied timeout value is relative or absolute?

-- Buck



