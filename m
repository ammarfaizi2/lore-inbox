Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285496AbRLNUg5>; Fri, 14 Dec 2001 15:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285497AbRLNUgr>; Fri, 14 Dec 2001 15:36:47 -0500
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:1157 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S285496AbRLNUgg>;
	Fri, 14 Dec 2001 15:36:36 -0500
Date: Fri, 14 Dec 2001 12:36:28 -0800
From: Simon Kirby <sim@netnation.com>
To: Andries.Brouwer@cwi.nl
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill(-1,sig)
Message-ID: <20011214123628.A22506@netnation.com>
In-Reply-To: <UTC200112141734.RAA20953.aeb@cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200112141734.RAA20953.aeb@cwi.nl>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2001 at 05:34:48PM +0000, Andries.Brouwer@cwi.nl wrote:

> + * POSIX (2001) specifies "If pid is -1, sig shall be sent to all processes
> + * (excluding an unspecified set of system processes) for which the process
> + * has permission to send that signal."
> + * So, probably the process should also signal itself.
> -			if (p->pid > 1 && p != current) {
> +			if (p->pid > 1) {

Argh, I hate this.  I fail to see what progress a process could make if
it kills everything _and_ itself.  I frequently use "kill -9 -1" to kill
everything except my shell, and now I'll have to kill everything else
manually, one by one.

If a process wants to commit suicide too, why doesn't it just do that
after?

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
