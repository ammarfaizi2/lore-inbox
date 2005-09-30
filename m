Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbVI3Oe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbVI3Oe7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 10:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbVI3Oe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 10:34:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14005 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030308AbVI3Oe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 10:34:58 -0400
Date: Fri, 30 Sep 2005 07:34:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: New and bogus(!) warning produced by sparse.
In-Reply-To: <Pine.LNX.4.64.0509300727450.3378@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0509300730500.3378@g5.osdl.org>
References: <Pine.LNX.4.60.0509301459020.23217@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.64.0509300727450.3378@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Sep 2005, Linus Torvalds wrote:
> 
> I see why it happens, will fix sparse momentarily (btw, for sparse bugs, 
> use "linux-sparse@vger.kernel.org" rather than LKML - since this is 
> clearly not a kernel problem ;)

Side note: it has nothing to do with bit-fields: it happens for any 
structure member that sparse will have incorrectly figured out as having a 
value pre-assigned to it. So even

	struct {
		int value;
	} dummy = { 0 };

	dummy.value = 1;

will generate the warning. It isn't that a bitfield cannot have it's 
address taken, it's that sparse has incorrectly "optimized" dummy.value to 
be 0, so it ends up evaluating it as

	0 = 1;

and says that it's trying to assign a non-lvalue.. Very stupid.

		Linus
