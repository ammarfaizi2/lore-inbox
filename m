Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268894AbUJFRQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268894AbUJFRQo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 13:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269310AbUJFRQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 13:16:43 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:44219 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S268894AbUJFRQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 13:16:29 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Stas Sergeev <stsp@aknet.ru>
Date: Wed, 6 Oct 2004 19:18:53 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: ESP corruption bug - what CPUs are affected? (patch att
Cc: linux-kernel@vger.kernel.org,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
X-mailer: Pegasus Mail v3.50
Message-ID: <59EA54D0987@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  6 Oct 04 at 20:18, Stas Sergeev wrote:
> Yes, if not for that anonymous guy, who kept posting
> to me until he finally convinced me that the Ring-0
> approach is not that difficult at all.
> So I tried... It was much more difficult to code
> up, but at the end it looks a little better
> and localized to entry.S completely. OTOH it
> touches the exception handlers, but not too much -
> it adds only 5 insns on the fast path. And the
> code is very fragile, but after I made all the
> magic numbers a #define consts, it actually looks
> not so bad.
> I don't know which patch is really better, so
> I am attaching both.

CPL0 solution is certainly more localized, but I have hard problems
to convice myself that it is actually safe.

I would appreciate if you could add comments what values are set
by ESPFIX_SWITCH_16 + 8 + 4 and simillar moves, and what they actually
do.  And convicing myself that ESPFIX_SWITCH_32 has just right value so

pushl %eax
pushl %es
lss ESPFIX_SWITCH_32,%esp
popl %es
popl %eax

actually works took almost an hour...
                                                    Petr
                                                    

