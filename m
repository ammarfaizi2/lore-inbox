Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314292AbSEMRCE>; Mon, 13 May 2002 13:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314325AbSEMRCD>; Mon, 13 May 2002 13:02:03 -0400
Received: from mailhost.mipsys.com ([62.161.177.33]:60609 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S314292AbSEMRCC>; Mon, 13 May 2002 13:02:02 -0400
From: <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Martin Dalecki <dalecki@evision-ventures.com>
Cc: Jens Axboe <axboe@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.15 IDE 62
Date: Mon, 13 May 2002 19:02:38 +0100
Message-Id: <20020513180238.400@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.44.0205130950350.19524-100000@home.transmeta.com>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>And then you make sure that nobody EVER uses any other lock than the queue
>lock.

Except that some controllers are perfectly safe to use both channels
at the same time, except when dealing with rare and sensible operations
(like changing channel settings) where a common set of registers is
shared between channels.

The controller driver in this case will want a lock per channel queue
and an internal lock to protect access to these shared registers. But
that lock can (and has to be) hidden in the controller driver.

Ben.



