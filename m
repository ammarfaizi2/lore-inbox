Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267888AbTBKRHw>; Tue, 11 Feb 2003 12:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267889AbTBKRHw>; Tue, 11 Feb 2003 12:07:52 -0500
Received: from mail4.bluewin.ch ([195.186.4.74]:42724 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id <S267888AbTBKRHv>;
	Tue, 11 Feb 2003 12:07:51 -0500
Date: Tue, 11 Feb 2003 18:17:36 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Henrik Persson <nix@socialism.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via rhine bug? (timeouts and resets)
Message-ID: <20030211171736.GA1359@k3.hellgate.ch>
Mail-Followup-To: Henrik Persson <nix@socialism.nu>,
	linux-kernel@vger.kernel.org
References: <200302111344.h1BDiMPY067070@sirius.nix.badanka.com> <20030211154449.GA2252@k3.hellgate.ch> <200302111652.h1BGq0PY067795@sirius.nix.badanka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302111652.h1BGq0PY067795@sirius.nix.badanka.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.60 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2003 17:51:09 +0100, Henrik Persson wrote:
> RL> The patch attached below will definitely solve some of the problems
> RL> you're seeing (e.g. "excessive collisions" on a switch). Feedback
> 
> Well.. It didn't solve my problems.. Still the same errors.. :/

That I find hard to believe. You were seeing a combination of "MII status
changed" and "Abort 0208, frame dropped.". That's because the driver makes
two mistakes: It treats 0200 as a link change (first message), and it
thinks 0008 indicates excessive collisions (second message).

In fact, 0008 means "transmission error", and 0200 specifies a buffer
underrun. The patch fixes that (lines 204, 213). If you are seeing the
_same_ errors my guess is you're still running the old driver. Check the
log at debug=3.

> RL> You shouldn't need to force full duplex, btw.
> 
> Nah, that was "just in case".. ;)

It's masking another bug that's waiting to hit you <g>.

Roger
