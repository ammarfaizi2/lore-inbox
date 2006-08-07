Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWHGXNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWHGXNW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWHGXNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:13:22 -0400
Received: from relay00.pair.com ([209.68.5.9]:24591 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S1751168AbWHGXNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:13:22 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
To: Daniel Jacobowitz <dan@debian.org>
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Date: Mon, 7 Aug 2006 18:12:55 -0500
User-Agent: KMail/1.9.4
Cc: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI> <eb8g8b$837$1@taverner.cs.berkeley.edu> <20060807225642.GA31752@nevyn.them.org>
In-Reply-To: <20060807225642.GA31752@nevyn.them.org>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608071813.18661.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 17:56, Daniel Jacobowitz wrote:
> On Mon, Aug 07, 2006 at 10:52:59PM +0000, David Wagner wrote:
> > I'm still trying to understand the semantics of this proposed
> > frevoke() implementation.  Can an attacker use this to forcibly
> > close some other processes' file descriptor?  Suppose the target
> > process has fd 0 open and the attacker revokes the file corresponding
> > to fd 0; what is the state of fd 0 in the target process?  Is it
> > closed?  If the target process then open()s another file, does it
> > get bound to fd 0?  (Recall that open() always binds to the lowest
> > unused fd.)  If the answers are "yes", then the security consequences
> > seem very scary.
>
> No, that's already been answered at least once.  The file remains open,
> but returns EBADF on various operations.

IIRC, it returns EBADF because the file actually gets closed. The file 
descriptor, on the other hand, is permanently leaked.

Have these details changed?

Thanks,
Chase
