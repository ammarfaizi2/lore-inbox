Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbUASRzZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 12:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbUASRzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 12:55:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:64449 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261552AbUASRzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 12:55:20 -0500
Date: Mon, 19 Jan 2004 09:55:06 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@redhat.com>
cc: Paul Mackerras <paulus@samba.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, rth@twiddle.net,
       davidm@napali.hpl.hp.com
Subject: Re: [PATCH] sort exception tables
In-Reply-To: <20040119093823.68f94083.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0401190951190.23846@home.osdl.org>
References: <16395.47717.472261.52870@cargo.ozlabs.ibm.com>
 <20040119093823.68f94083.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Jan 2004, David S. Miller wrote:
> 
> I have no objections to this patch, however I'd like to be reminded why we
> desire to sort this stuff, performance?

Yes, we've used a binary search for the last few years to look up the
entry, because a linear search makes things like real SIGSEGV's really
_really_ slow.

The linker sorts the thing normally, but gets confused by different code
sections. And while we right now only have init/exit sections (in addition 
to the normal code one), that already has caused problems several times. 

		Linus
