Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130010AbQLLVpE>; Tue, 12 Dec 2000 16:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129965AbQLLVoy>; Tue, 12 Dec 2000 16:44:54 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:25362 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S130076AbQLLVop>;
	Tue, 12 Dec 2000 16:44:45 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: John Cavan <johncavan@home.com>
Date: Tue, 12 Dec 2000 22:13:21 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.2.16 SMP: mtrr errors
CC: " Paul C. Nendick" <pauly@enteract.com>, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <F7CD5C16569@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Dec 00 at 16:07, John Cavan wrote:
> Petr Vandrovec wrote:
> > > kernel: mtrr: base(0xd4000000) is not aligned on a size(0x1800000) boundary
> > > last message repeated 2 times
> > 
> > For some strange reason X thinks that you have 24MB of memory on the G450.
> > You can either create 32MB write-combining region at 0xd4000000, or
> > teach X that your device occupies 32MB and not 24 (you should do it anyway,
> > region size can be only power of two)...
> 
> Petr, the Matrox card splits the memory between the two video screens
> when running in a multi-head configuration and "pretends" that it is two
> distinct cards. Thus, a 32 mb card will register an mtrr for 24mb and
> for 8mb seperately when in this mode.

That's wrong. They must first register MTRR and then split it to
24+8, as they cannot register 24MB range. They can split it
16+16, or (16+8)+8, but at cost of 1 (or 2) additional MTRR entries -
and there is very limited number of possible MTRRs.

Matroxfb also splits Matrox memory in 24:8, but it registers only one
region in mtrr. Of course, in X, as mtrr registration is done by map
videomemory, you must tell this function to not register mtrr...

                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
