Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUA1UG0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 15:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265923AbUA1UG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 15:06:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:958 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266003AbUA1UGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 15:06:23 -0500
Date: Wed, 28 Jan 2004 12:06:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: willy@debian.org, ishii.hironobu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [RFC/PATCH, 2/4] readX_check() performance evaluation
In-Reply-To: <20040128204049.627e6312.ak@suse.de>
Message-ID: <Pine.LNX.4.58.0401281205250.28145@home.osdl.org>
References: <00a301c3e541$c13a6350$2987110a@lsd.css.fujitsu.com>
 <Pine.LNX.4.58.0401271847440.10794@home.osdl.org>
 <20040128182003.GL11844@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0401281129570.28145@home.osdl.org> <20040128204049.627e6312.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Jan 2004, Andi Kleen wrote:
>
> On Wed, 28 Jan 2004 11:33:33 -0800 (PST)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > For example, if checking for an error involves actually reading a value 
> > from a bridge register, then that implies some _serious_ amount of 
> > serialization and external CPU stuff.
> 
> Which is _extremly_ hard to do from an MCE handler ...

So don't do it in the MCE handler.

Just set a flag aka "may need checking", and let the check be done by the 
actual "read_pcix_error()" code.

		Linus
