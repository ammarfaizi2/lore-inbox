Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132482AbRD1NXH>; Sat, 28 Apr 2001 09:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132497AbRD1NWr>; Sat, 28 Apr 2001 09:22:47 -0400
Received: from chiara.elte.hu ([157.181.150.200]:47631 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132482AbRD1NWk>;
	Sat, 28 Apr 2001 09:22:40 -0400
Date: Sat, 28 Apr 2001 15:21:05 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
Cc: Fabio Riccardi <fabio@chromium.com>, <linux-kernel@vger.kernel.org>
Subject: Re: X15 alpha release: as fast as TUX but in user space
In-Reply-To: <20010428161502.I3529@niksula.cs.hut.fi>
Message-ID: <Pine.LNX.4.33.0104281516180.10295-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 28 Apr 2001, Ville Herva wrote:

> Uhh, perhaps I'm stupid, but why not cache the date field and update
> the field once a five seconds? Or even once a second?

yes, that should work. but that means possibly updating thousands of (or
more) cached headers, which has some overhead ...

> I mean, at the rate of thousands of requests per second that should
> give you some advantage over dynamically generating it -- especially
> if that's the only thing hindering copletely sendfile()'ing the
> answer.

well, the method i suggested was to use sendfile() twice: first the
(cached, or freshly constructed) headers put into a big file, then the
body itself (which is the original file, accessed via cached file
descriptors).

(splitting up the header and the body has the benefit of not dual-caching
the same webcontent. this is what TUX does too.)

	Ingo

