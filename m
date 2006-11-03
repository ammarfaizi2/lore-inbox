Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753253AbWKCOj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253AbWKCOj0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 09:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753254AbWKCOj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 09:39:26 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:44514 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1753253AbWKCOjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 09:39:25 -0500
Date: Fri, 3 Nov 2006 15:39:24 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <17739.18555.30814.617461@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.64.0611031532350.27698@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <p73velxju18.fsf@verdi.suse.de> <Pine.LNX.4.64.0611030235050.7781@artax.karlin.mff.cuni.cz>
 <17739.18555.30814.617461@gargle.gargle.HOWL>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Nov 2006, Nikita Danilov wrote:

> Mikulas Patocka writes:
> > > Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> writes:
> > >
> > >> new method to keep data consistent in case of crashes (instead
> > >> of journaling),
> > >
> > > What is that method?
> >
> > Some tricks to avoid journal --- see
> > http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/download/INTERNALS
> >
> > --- unlike journaling it survives only 65536 crashes :)
>
> What happens when hard-linked file is accessed, and it is found that
> last fnode (one in fixed_fnode_block), has wrong "crash count"?
>
> Nikita.

Fixed fnode block contains (txc,cc) pair describing which fnode and nlink 
count is valid. --- currently two fnodes are superflous (there could be 
just one), they are reserved for the possibility to atomically modify 
extended attributes --- but there is no code currently that does it.

The fnodes live on their own with their own (txc,cc) pair --- it is a bit 
confusing to have pair on both fixed_fnode_block and fnode --- the reason 
is that the code for handling fnodes in directories can be reused to 
handle fnodes in fixed_fnode_blocks and I can avoid many
if (is_fnode_fixed()) branches.

If the fnode in fixed_fnode_block has invalid crash count, 
fixed_fnode_block's (cc,txc) pair should never point to it. Or did it 
happen to you?

Mikulas
