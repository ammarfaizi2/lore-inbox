Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266176AbRGSXYI>; Thu, 19 Jul 2001 19:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266224AbRGSXX5>; Thu, 19 Jul 2001 19:23:57 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:34308 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266176AbRGSXXt>; Thu, 19 Jul 2001 19:23:49 -0400
Message-ID: <3B576BF7.DE801DC2@transmeta.com>
Date: Thu, 19 Jul 2001 16:23:35 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Julian Anastasov <ja@ssi.bg>
CC: Linus Torvalds <torvalds@transmeta.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: cpuid_eax damages registers (2.4.7pre7)
In-Reply-To: <Pine.LNX.4.33.0107200206460.1820-100000@u.domain.uli>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Julian Anastasov wrote:
> 
>         Hello,
> 
> On Thu, 19 Jul 2001, Linus Torvalds wrote:
> 
> > No. It's correct, because cpuid doesn't have any side effects (*), so we
> > don't need to mark it volatile. gcc is free to remove it if nothing uses
> > the outputs, for example. But gcc cannot (and generally does not) ignore
> > outputs that _are_ specified.
> 
>         My understanding was that eax, ... edx are declared as
> local vars and so their values can't be used out of the current
> function scope, even when they are defined in inline func. So, I
> assume they can be optimized (the fact is that they are not used)
> and may be gcc forgets them. True, may be the docs do not cover
> such situations but my first thought was not to explain everything
> with bugs.
> 

Well, your first thought was wrong.  It is a bug.  Sorry.

However, your argument basically explains why adding "volatile" does work
-- it keeps gcc from thinking that it can optimize away something that it
otherwise couldn't.

However, it's still a bug.

	-hpa
