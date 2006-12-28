Return-Path: <linux-kernel-owner+w=401wt.eu-S1754952AbWL1T7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952AbWL1T7Y (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 14:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754954AbWL1T7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 14:59:24 -0500
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:51819 "EHLO
	mail-gw1.sa.eol.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754951AbWL1T7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 14:59:23 -0500
To: bhalevy@panasas.com
CC: arjan@infradead.org, mikulas@artax.karlin.mff.cuni.cz, jaharkes@cs.cmu.edu,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
In-reply-to: <4593E1B7.6080408@panasas.com> (message from Benny Halevy on Thu,
	28 Dec 2006 17:24:39 +0200)
Subject: Re: Finding hardlinks
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>	 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>	 <20061221185850.GA16807@delft.aura.cs.cmu.edu>	 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>	 <1166869106.3281.587.camel@laptopd505.fenrus.org>	 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>	 <4593890C.8030207@panasas.com> <1167300352.3281.4183.camel@laptopd505.fenrus.org> <4593E1B7.6080408@panasas.com>
Message-Id: <E1H01Og-0007TF-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 28 Dec 2006 20:58:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> It seems like the posix idea of unique <st_dev, st_ino> doesn't
> >> hold water for modern file systems 
> > 
> > are you really sure?
> 
> Well Jan's example was of Coda that uses 128-bit internal file ids.
> 
> > and if so, why don't we fix *THAT* instead
> 
> Hmm, sometimes you can't fix the world, especially if the filesystem
> is exported over NFS and has a problem with fitting its file IDs uniquely
> into a 64-bit identifier.

Note, it's pretty easy to fit _anything_ into a 64-bit identifier with
the use of a good hash function.  The chance of an accidental
collision is infinitesimally small.  For a set of 

         100 files: 0.00000000000003%
   1,000,000 files: 0.000003%

And usually (tar, diff, cp -a, etc.) work with a very limited set of
st_ino's.  An app that would store a million st_ino values and compare
each new to all the existing ones would be having severe performance
problems and yet _almost never_ come across a false positive.

Miklos
