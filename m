Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263032AbUEMBz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbUEMBz6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 21:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUEMBz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 21:55:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:1966 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263032AbUEMBzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 21:55:55 -0400
Date: Wed, 12 May 2004 18:55:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: chrisw@osdl.org, linux-kernel@vger.kernel.org, luto@myrealbox.com
Subject: Re: [PATCH 0/2] capabilities
Message-Id: <20040512185528.2e6bea8e.akpm@osdl.org>
In-Reply-To: <40A2D449.7090103@myrealbox.com>
References: <200405112024.22097.luto@myrealbox.com>
	<20040512164132.2d30dac2.akpm@osdl.org>
	<40A2D449.7090103@myrealbox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@myrealbox.com> wrote:
>
> > 
> > What if there are existing applications which are deliberately or
> > inadvertently relying upon the current behaviour?  That seems unlikely, but
> > the consequences are gruesome.
> 
> Like something that turns KEEPCAPS on then setuid()s then executes an 
> untrusted program?

Or if it simply has caps and then does exec.

> > If I'm right in this concern, the fixed behaviour should be opt-in.  That
> > could be via a new prctl() thingy but I think it would be better to do it
> > via a kernel boot parameter.  Because long-term we should have the fixed
> > semantics and we should not be making people change userspace for some
> > transient 2.6-only kernel behaviour.
> 
> The prctl would defeat the purpose (imagine if bash forgot the prctl -- 
> then the whole thing is pointless).

yup, lots of apps would need to be changed to interface with something
which won't be present in 2.8 kernels.

>  I'll cook up the boot parameter in 
> the next couple days (probably with a config option and some kind of 
> warning that the old behavior is deprecated).

I wouldn't bother with a config option.

>  Is it a problem if I make 
> the changes to init's state unconditional?  (I still don't see why 
> CAP_SETPCAP is dangerous for root to have...)

I'd be more comfortable (ie: comfort level non-zero) if there was zero
behaviour change if the boot option isn't enabled.

> The only concern is that some new code relies on the new inheritable 
> semantics.  That shouldn't be so bad, though, since that's just an extra 
> precaution (if there are insecure setuid binaries around, you already 
> have problems).

Yes, we can live with that.  The price of prior sins.
