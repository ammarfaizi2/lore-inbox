Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270453AbTHLOfS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 10:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270455AbTHLOfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 10:35:18 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:24470
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270453AbTHLOfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 10:35:12 -0400
From: Con Kolivas <kernel@kolivas.org>
To: gaxt <gaxt@rogers.com>
Subject: Re: WINE + Galciv + 2.6.0-test3-mm1-O15
Date: Wed, 13 Aug 2003 00:40:50 +1000
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>
References: <3F22F75D.8090607@rogers.com> <200307292246.36808.kernel@kolivas.org> <3F38FCBA.1000008@rogers.com>
In-Reply-To: <3F38FCBA.1000008@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308130040.50090.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003 00:42, gaxt wrote:
> Photoshop 6 (yes, legal owned version) in wine is flawless (as it was
> with 2.6.0-test3)
>
> Galciv plays videos quite smoothly but as soon as I run it it will
> freeze the cursor for 12-15 seconds every half-minute or so even within
> the game itself which is turn-based strategy without a lot of whizbang
> stuff. In the past, the videos would stutter but the game would not
> suffer from more than short pauses now and then.

Yes, herein lies one of those mysteries that still eludes me but I have been 
investigating it. I can now reproduce in other applications what appears to 
be the problem - Two cpu hogs, X and evolution for example are running and 
evolution is making X the cpu hog. The problem is that X gets demoted whereas 
evolution doesn't. Strangely, dropping evolution to nice +1 or making X -1 
seems to change which one gets demoted, and X is now much smoother. I assume 
the same thing is happening here between wine and wineserver, which is why 
you've seen reversal of priorities in your previous posts. See if renicing 
one of them +1 helps for the time being. I will continue investigating to 
find out why the heck this happens and try and fix it.

Con

P.S. I've cc'ed MG because he has seen the scheduler do other forms of 
trickery and may have thoughts on why this happens.

