Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbTFPLUE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 07:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbTFPLUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 07:20:04 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:17848 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263738AbTFPLUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 07:20:01 -0400
Date: Mon, 16 Jun 2003 13:33:51 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: DervishD <raul@pleyades.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND][PATCH] against mmap.c (do_mmap_pgoff) and a note
Message-ID: <20030616113351.GB18717@wohnheim.fh-wedel.de>
References: <20030421110427.GA127@DervishD> <20030615102039.GA1063@wohnheim.fh-wedel.de> <20030616094911.GB43@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030616094911.GB43@DervishD>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 June 2003 11:49:11 +0200, DervishD wrote:
>  * Jörn Engel <joern@wohnheim.fh-wedel.de> dixit:
>  
> > >  		return addr;
> > >  
> > > -	if (len > TASK_SIZE)
> > > -		return -EINVAL;
> > > -
> > >  	len = PAGE_ALIGN(len);
> > >  
> > > +	if (len > TASK_SIZE || len == 0)
> > > +		return -EINVAL;
> > > +
> > 
> > PAGE_ALIGN(0) = 0
> > PAGE_ALIGN(1) = PAGE_SIZE
> > 
> > Again, no change.
> 
>     There is a change in archs where TASK_SIZE is the entire
> addressable space (like sparc64). Ask Dave S., again. The problem did
> arise when TASK_SIZE is ~0. Then semantics change.

True.  PAGE_ALIGN(-1) = 0 and that case would not get caught with the
old code.  Looks good to me.

Jörn

-- 
Public Domain  - Free as in Beer
General Public - Free as in Speech
BSD License    - Free as in Enterprise
Shared Source  - Free as in "Work will make you..."
