Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272053AbTG2T5K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 15:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272054AbTG2T5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 15:57:10 -0400
Received: from maild.telia.com ([194.22.190.101]:18172 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id S272053AbTG2T5F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 15:57:05 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
From: Roger Larsson <roger.larsson@norran.net>
To: "ismail (cartman) donmez" <kde@myrealbox.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm1
Date: Tue, 29 Jul 2003 21:59:16 +0200
User-Agent: KMail/1.5.9
References: <20030727233716.56fb68d2.akpm@osdl.org> <200307290833.02848.kde@myrealbox.com>
In-Reply-To: <200307290833.02848.kde@myrealbox.com>
Cc: Davide Libenzi <davidel@xmailserver.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200307292159.17137.roger.larsson@norran.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 July 2003 07.33, ismail (cartman) donmez wrote:
> Hi,
>
> Some things I noticed:
>
> -- snip --
>
> 2- Con's patch makes KDE's sound daemon skip ( aRts ) when using Juk ( KDE
> JukeBox ) [ to skip just minimize/maximize any window fast ] . Seems like
> problem is at aRts decoding as mplayer -ao arts works fine without skips.
>

Is mplayer suid root? (allow SCHED_FIFO/RR usage)
To get the equivalent function you need artswrapper to be suid root,
and "Run soundserver with realtime priority" feature enabled in aRTs config.

[Dangerous with multiuser setups - user can add a plug in that loops forever 
with higher priority than all other processes -> dead system.
The SCHED_SOFTRR patch would be a very welcome addition.
a) No need for suid root, artswrapper tries to use SCHED_FIFO

   Davide - SCHED_FIFO should also be handled as a SCHED_SOFTRR request!
   Not only SCHED_RR (SCHED_FIFO is more frequently used!)

b) Automatic prevention of overuse 
]

If this is not the case - my mplayer is not suid root.
aRTs adds some overhead to allow mixing audio from several applications.
(even if this is not necessary on some audio boards like SB Live!)
To get the same kind of overhead you should run mplayer with output through 
arts...

artsdsp mplayer ...

The final thing to check is KDE Audio Buffer Size (if this is small then it 
won't matter if mplayer uses a big buffer...)

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
