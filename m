Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268875AbRG0QO6>; Fri, 27 Jul 2001 12:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268876AbRG0QOs>; Fri, 27 Jul 2001 12:14:48 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:11019 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S268875AbRG0QOk>;
	Fri, 27 Jul 2001 12:14:40 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: Fri, 27 Jul 2001 18:14:15 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] gcc-3.0.1 and 2.4.7-ac1
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <9D6DD5713F9@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 27 Jul 01 at 18:03, Florian Weimer wrote:
> "Petr Vandrovec" <VANDROVE@vc.cvut.cz> writes:
> 
> > Just adding '-finline-limit=150' fixes all of them
> 
> This is not a fix, this is a workaround which is suitable for some
> specific GCC release(s).  The optimization decisions surrounding
> inlining are likely to change again, so this will break almost
> certainly in the future.

I found that main problem is in __constant_memcpy. This is very large
in internal representation (~70 'units'), so any kernel function which 
contains two memcpy calls with constant length cannot be inlined with 
current settings because of it contains 140+ internal operations - although
if compiler then generates static function (instead of inlined), it is ~10 
i386 operations long, from which 4 are push %edi/%esi and pop %esi/%edi...

                                            Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
