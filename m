Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130775AbRCFNnA>; Tue, 6 Mar 2001 08:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130779AbRCFNml>; Tue, 6 Mar 2001 08:42:41 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:11019 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S130775AbRCFNmj>;
	Tue, 6 Mar 2001 08:42:39 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alexander Viro <viro@math.psu.edu>
Date: Tue, 6 Mar 2001 14:41:47 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: d_add on negative dentry?
CC: linux-kernel@vger.kernel.org, urban@teststation.com
X-mailer: Pegasus Mail v3.40
Message-ID: <1492C65485C@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  5 Mar 01 at 18:08, Alexander Viro wrote:
> On Tue, 6 Mar 2001, Urban Widmark wrote:
> 
> > 
> > Is it valid to call d_add on a negative dentry?
> > (or on a dentry that is already linked in d_hash, but all negative
> >  dentries are, right?)
> 
> Not all of them. It _is_ legal to do d_add() on a negative dentry.
> Doing that for hashed dentries is a bug. Use d_instantiate() instead.
>                             Cheers,
>                                 Al
> 
> PS: as for the patch, better make it
>     d_instantiate(...);
>     if (!hashed)
>         d_rehash(...);

It could explain why I'm getting once a month CPU spinning in d_lookup()
because of some circular list is no more one circle... 
Many thanks, I'll apply it to ncpfs ASAP.
                                        Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
