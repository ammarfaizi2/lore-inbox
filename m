Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263339AbTJ0Cpq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 21:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTJ0Cpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 21:45:46 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:26640 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263339AbTJ0Cpo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 21:45:44 -0500
Date: Sun, 26 Oct 2003 18:45:38 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031027024538.GD5198@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14> <20031016230448.GA29279@pegasys.ws> <20031027022231.GD4511@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031027022231.GD4511@matchmail.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Unauthorised duplication and storage of this email is a violation of international copyright law and is subject to prosecution.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 26, 2003 at 06:22:31PM -0800, Mike Fedyk wrote:
> On Thu, Oct 16, 2003 at 04:04:48PM -0700, jw schultz wrote:
> > 2.  External collision: The smaller hash size to unit count
> >     ratio the greater liklihood of false positives.  To put
> >     it in the extreme: if you have 10,000 blocks you are
> >     almost guaranteed to get false positives on a 16 bit
> >     hash.  This is similar to filling the namespace.  It is
> >     external collision that was killing rsync on iso images.
> 
> What about making one bit changes in the block at a random location (the
> same bit on both sides), and comparing the hashes again.
> 
> This would work for something that is trying to save bandwidth over a
> network link, but wouldn't save anything in a Compare-by-hash File System
> (why hash again when you need to read the block anyway?).
> 
> One thought for rsync would be to have a 4 step process (the first two are
> how it operates now according to another sub-thread):
> 
>  1) Check the block with a weak 16bit hash
>  
>  2) Check the block with a stronger 32bit hash (if step 1 had a collision)
> 
>  3) Check the block with SHA1 (if step 2 had a collision)
> 
>  4) Make a one bit change at a random location in the block, but at the same
>     place on both ends of the transfer and repeat steps 1 to 3
>     
> It's arguable how much of an optimization the 16bit hash is, but it's there
> and maybe it's a win, and maybe not.  It's also arguable just how much
> bandwidth you're going to save with the extra steps 3, and the recursive 4.
> Maybe 4 should be just a recheck with SHA1, and the recursive check isn't
> needed, but I haven't done any hash benchmarks.

My "extreme" example was for illustration only. 16 bits was
chosen as a size to get the numberspace into a scale where
the issue become obvious.

Rsync uses a minimum of a 48 bit hash per block.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
