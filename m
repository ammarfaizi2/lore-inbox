Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263142AbTCMWmL>; Thu, 13 Mar 2003 17:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263147AbTCMWmL>; Thu, 13 Mar 2003 17:42:11 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12037 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263142AbTCMWmK>; Thu, 13 Mar 2003 17:42:10 -0500
Message-ID: <3E710BB0.8000300@zytor.com>
Date: Thu, 13 Mar 2003 14:52:32 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       davej@suse.de, torvalds@transmeta.com
Subject: Re: [PATCH] cpu/hw_random cleanups
References: <200303132249.h2DMnj912399@devserv.devel.redhat.com>
In-Reply-To: <200303132249.h2DMnj912399@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>>For example, I wonder if storing Intel's cpuid(0x00000001) ecx
>>>register output is wise on older Intel cpus.  I worry about garbage
>>>appearing there.  Is that a false worry?
>>>
>>
>>Yes; it should be completely safe.
> 
> I have to admit I'd be more comfortable if we only set those bits IFF
> we know they are valid to check, not so much because we need to right now
> but out of a desire to make less mistakes possible
>

The problem is that you risk exactly the opposite mistake -- it's called
"anticompetitive feature lockout."  Intel would happily tell you to do
it; in fact, if you follow Intel guidelines or use their sample code it
will treat anything that isn't an Intel chip like a 486.

If any chip that claims to support CPUID level 00000001h reports
anything other than zero in this field, that chip is broken and we
should deal with it as a chip-specific bug.  At this point there are no
chips which are known to have this bug (and there are, after all, only a
finite number of chips out there.)

	-hpa

