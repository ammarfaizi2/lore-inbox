Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266769AbUGLJ1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266769AbUGLJ1r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 05:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266768AbUGLJ1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 05:27:46 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:57279 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S266769AbUGLJ0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 05:26:03 -0400
Date: Mon, 12 Jul 2004 11:26:00 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: Linux 2.6.8-rc1
Message-ID: <20040712092600.GB5979@merlin.emma.line.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	viro@parcelfarce.linux.theplanet.co.uk
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jul 2004, Linus Torvalds wrote:

> Ok, there's been a long time between "public" releases, although the
> automated BK snapshots have obviously been keeping people up-to-date. 
> Sorry about that, I blame mainly moving boxes and stuff around...

...

> Alexander Viro:
    ...
>   o sparse: rt_sigsuspend/sigaltstack sanitized

I consider this harmful right now, full log:

ChangeSet@1.1743, 2004-06-18 13:35:31-07:00, viro@parcelfarce.linux.theplanet.co.uk
  [PATCH] sparse: rt_sigsuspend/sigaltstack sanitized
  
  rt_sigsuspend() and sigaltstack() prototype changed; instead of
  playing games with casts of argument address to struct pt_regs * and
  digging through it, we declare them as
  
        int <fn>(struct pt_regs regs)
  
  instead.

This ChangeSet causes Java to get killed right away, to see this, just
type "Java". Excluding this ChangeSet (ID
viro@parcelfarce.linux.theplanet.co.uk[torvalds]|ChangeSet|20040618203531|62233)
fixes the problem for me.

Thanks to Go Taniguchi for isolating the change set.
