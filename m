Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278082AbRJZJel>; Fri, 26 Oct 2001 05:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278086AbRJZJeb>; Fri, 26 Oct 2001 05:34:31 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:64932 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S278085AbRJZJe2>; Fri, 26 Oct 2001 05:34:28 -0400
Date: Fri, 26 Oct 2001 05:35:03 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Allan Sandfeld <linux@sneulv.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel compiler
Message-ID: <20011026053503.U25384@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <E15wmgp-0005E8-00@the-village.bc.nu> <3BD841B7.5060405@toughguy.net> <20011026001354.C2245@werewolf.able.es> <E15x38c-0000Dh-00@Princess>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15x38c-0000Dh-00@Princess>; from linux@sneulv.dk on Fri, Oct 26, 2001 at 11:18:46AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2001 at 11:18:46AM +0200, Allan Sandfeld wrote:
> > Last paragraph is the key. Perhaps previous gcc'd did not all his work
> > as the manual says (ie, did not kill the non-inline version, bug),
> > but people has got used to the bug, and see it as a feature.
> 
> I believe '-fkeep-inline-functions' is your friend in this case. I haven't 
> tested it though on the kernel.

Definitely not. -fkeep-inline-functions will not only prevent in compiler
eyes unused static functions from beeing optimized away, but you'll get tons
of code you really don't need.
__attribute__((used)) is what you can use in current gcc trunk to just say
the compiler that it should not optimize away a particular function even if
it seems to be unused at -O3 (e.g. it might be referenced from inline assembly,
whatever).
No matter what, using -O3 for kernel builds is a bad idea, in vast majority
functions which make sense to be inlined are in the kernel marked so with
inline keyword, and the rest does not. With -O3 for kernel you just get
bigger code with no gains (if there are some gains somewhere, then it should
be considered to be marked inline on a case by case basis).

	Jakub
