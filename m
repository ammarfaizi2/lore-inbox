Return-Path: <linux-kernel-owner+w=401wt.eu-S964956AbXABTfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbXABTfQ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 14:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbXABTfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 14:35:15 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4761 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964955AbXABTfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 14:35:13 -0500
Date: Tue, 2 Jan 2007 19:15:05 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bhalevy@panasas.com, arjan@infradead.org, mikulas@artax.karlin.mff.cuni.cz,
       jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@ietf.org
Subject: Re: Finding hardlinks
Message-ID: <20070102191504.GA5276@ucw.cz>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz> <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu> <20061221185850.GA16807@delft.aura.cs.cmu.edu> <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz> <1166869106.3281.587.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz> <4593890C.8030207@panasas.com> <1167300352.3281.4183.camel@laptopd505.fenrus.org> <4593E1B7.6080408@panasas.com> <E1H01Og-0007TF-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1H01Og-0007TF-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >> It seems like the posix idea of unique <st_dev, st_ino> doesn't
> > >> hold water for modern file systems 
> > > 
> > > are you really sure?
> > 
> > Well Jan's example was of Coda that uses 128-bit internal file ids.
> > 
> > > and if so, why don't we fix *THAT* instead
> > 
> > Hmm, sometimes you can't fix the world, especially if the filesystem
> > is exported over NFS and has a problem with fitting its file IDs uniquely
> > into a 64-bit identifier.
> 
> Note, it's pretty easy to fit _anything_ into a 64-bit identifier with
> the use of a good hash function.  The chance of an accidental
> collision is infinitesimally small.  For a set of 
> 
>          100 files: 0.00000000000003%
>    1,000,000 files: 0.000003%

I do not think we want to play with probability like this. I mean...
imagine 4G files, 1KB each. That's 4TB disk space, not _completely_
unreasonable, and collision probability is going to be ~100% due to
birthday paradox.

You'll still want to back up your 4TB server...

							Pavel
-- 
Thanks for all the (sleeping) penguins.
