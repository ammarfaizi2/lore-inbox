Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262184AbSIZFFq>; Thu, 26 Sep 2002 01:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262185AbSIZFFq>; Thu, 26 Sep 2002 01:05:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17427 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262184AbSIZFFq>; Thu, 26 Sep 2002 01:05:46 -0400
Date: Wed, 25 Sep 2002 22:12:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: akpm@digeo.com, <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/4] prepare_to_wait/finish_wait sleep/wakeup API
In-Reply-To: <20020925.213427.116352583.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0209252211280.1203-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Sep 2002, David S. Miller wrote:
> 
> Ok, so if the condition retest fails at wakeup (someone got to the
> event before us), it's ok because we add ourselves back to the wait
> queue first, mark ourselves as sleeping, _then_ retest.

Right. The looping case (if somebody else was first) is slowed down
marginally, but the common case is sped up and needs one less time through
the waitqueue lock.

		Linus

