Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSHRQua>; Sun, 18 Aug 2002 12:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSHRQua>; Sun, 18 Aug 2002 12:50:30 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:28173
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S315374AbSHRQu3>; Sun, 18 Aug 2002 12:50:29 -0400
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
From: Robert Love <rml@tech9.net>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020818042818.GG21643@waste.org>
References: <20020818021522.GA21643@waste.org>
	<Pine.LNX.4.44.0208172001530.1491-100000@home.transmeta.com> 
	<20020818042818.GG21643@waste.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Aug 2002 12:54:27 -0400
Message-Id: <1029689668.903.19.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-18 at 00:28, Oliver Xymoron wrote:

> Now there's currently an orthogonal problem that /dev/urandom can
> deplete /dev/random's entropy pool entirely and things like generating
> sequence numbers get in the way. I intend to fix that separately. 

Curious, how do you intend on doing this?

The reason /dev/urandom depletes /dev/random (it actually just lowers
the entropy estimate) is due to the assumption that knowledge of the
state is now known, so the estimate of how random (actually, we mean
non-deterministic here) needs to decrease...

Are you thinking of (semi) decoupling the two pools?

I sort of agree with you that we should make random "stricter" and push
some of the sillier uses onto urandom... but only to a degree or else
/dev/random grows worthless.  Right now, on my workstation with plenty
of user input and my netdev-random patches, I have plenty of entropy and
can safely use random for everything... and I like that.

	Robert Love

