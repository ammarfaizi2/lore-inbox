Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbTFPJwf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 05:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTFPJwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 05:52:35 -0400
Received: from madrid10.amenworld.com ([217.174.194.138]:35598 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S263610AbTFPJwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 05:52:34 -0400
Date: Mon, 16 Jun 2003 11:49:11 +0200
From: DervishD <raul@pleyades.net>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND][PATCH] against mmap.c (do_mmap_pgoff) and a note
Message-ID: <20030616094911.GB43@DervishD>
References: <20030421110427.GA127@DervishD> <20030615102039.GA1063@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030615102039.GA1063@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 * Jörn Engel <joern@wohnheim.fh-wedel.de> dixit:
> > -	if (!len)
> > +	if (len == 0)
> No change.

    Just cosmethic, ask Dave S. Miller, he is the author of the
change, I'm just doing the patch for him.
 
> >  		return addr;
> >  
> > -	if (len > TASK_SIZE)
> > -		return -EINVAL;
> > -
> >  	len = PAGE_ALIGN(len);
> >  
> > +	if (len > TASK_SIZE || len == 0)
> > +		return -EINVAL;
> > +
> 
> PAGE_ALIGN(0) = 0
> PAGE_ALIGN(1) = PAGE_SIZE
> 
> Again, no change.

    There is a change in archs where TASK_SIZE is the entire
addressable space (like sparc64). Ask Dave S., again. The problem did
arise when TASK_SIZE is ~0. Then semantics change.
 
    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
