Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136608AbREKNuR>; Fri, 11 May 2001 09:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137137AbREKNuH>; Fri, 11 May 2001 09:50:07 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:31236 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S136608AbREKNuC>;
	Fri, 11 May 2001 09:50:02 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Tom Leete <tleete@mountain.net>
Date: Fri, 11 May 2001 15:48:39 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] __up_read and gcc-3.0
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <29BB15646EB@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 May 01 at 9:13, Tom Leete wrote:
> >         __asm__ __volatile__(
> >                 "# beginning __up_read\n\t"
> > +               "  movl      %2,%%edx\n\t"
> >  LOCK_PREFIX    "  xadd      %%edx,(%%eax)\n\t" /* subtracts 1, returns the old value */
> >                 "  js        2f\n\t" /* jump if the lock is being waited upon */
> >                 "1:\n\t"
> 
> My solution to this was to relax +d(tmp) to +m(tmp). Posted a few days ago.
> I have larger problems with 2.4.5-pre1 and have not gone back to check what
> comes out. Being a product of pure reason (and not much of that), mine
> deserves suspicion.

Changing +d => +m could generate 'xadd (%%xyz),(%%eax)' which does not exist.
Maybe +r, but in this case do not forget to add push/pop %%edx around
call to rwsem_wake. Otherwise you can have some corruption if gcc decides
to use %edx for some local variable around __up_read.
                                                    Best regards,
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
                                                        
