Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130519AbRCTRYX>; Tue, 20 Mar 2001 12:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130520AbRCTRYO>; Tue, 20 Mar 2001 12:24:14 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:6155 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130519AbRCTRYJ>; Tue, 20 Mar 2001 12:24:09 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: LDT allocated for cloned task!
Date: 20 Mar 2001 09:23:14 -0800
Organization: Transmeta Corporation
Message-ID: <9983m2$1l5$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0103201745080.1701-100000@pau.intranet.ct>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0103201745080.1701-100000@pau.intranet.ct>,
Pau  <linuxnow@terra.es> wrote:
>
>I've been running 2.4.3-pre4 for a few days now and today I've got this
>message in the logs a couple of times. Is it harmless?

It's harmless.

It's really a warning that says: the mm that you allocated a new LDT for
may have multiple users, and while the LDT is added to all of them, we
don't guarantee _when_ the other users will actually see the LDT.

It so happens that the other users are probably just something like
"top" or similar, that increment the MM count to make sure that the MM
doesn't go away while they get information about the process. And those
users don't care about the LDT in the least.

		Linus
