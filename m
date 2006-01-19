Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161092AbWASAWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161092AbWASAWl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161090AbWASAWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 19:22:40 -0500
Received: from cantor2.suse.de ([195.135.220.15]:30920 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161088AbWASAWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 19:22:39 -0500
From: Neil Brown <neilb@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Date: Thu, 19 Jan 2006 11:22:31 +1100
Message-ID: <17358.56263.806371.53617@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Ross Vandegrift <ross@jose.lug.udel.edu>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 000 of 5] md: Introduction
In-Reply-To: message from Michael Tokarev on Tuesday January 17
References: <20060117174531.27739.patches@notabene>
	<43CCA80B.4020603@tls.msk.ru>
	<20060117095019.GA27262@localhost.localdomain>
	<43CCD453.9070900@tls.msk.ru>
	<20060117160829.GA16606@lug.udel.edu>
	<43CD3388.9050107@tls.msk.ru>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday January 17, mjt@tls.msk.ru wrote:
> 
> As a sort of conclusion.
> 
> There are several features that can be implemented in linux softraid
> code to make it real Raid, with data safety goal.  One example is to
> be able to replace a "to-be-failed" drive (think SMART failure
> predictions for example) without removing it from the array with a
> (hot)spare (or just a replacement) -- by adding the new drive to the
> array *first*, and removing the to-be-replaced one only after new is
> fully synced.  Another example is to implement some NVRAM-like storage
> for metadata (this will require the necessary hardware as well, like
> eg a flash card -- I dunno how safe it can be).  And so on.

proactive replacement before complete failure is a good idea and is
(just recently) on my todo list.  It shouldn't be too hard.

> 
> The current MD code is "almost here", almost real.  It still has some
> (maybe minor) problems, it still lacks some (again maybe minor) features
> wrt data safety.  Ie, it still can fail, but it's almost here.

concrete suggestions are always welcome (though sometimes you might
have to put some effort into convincing me...)

> 
> While current development is going to implement some new and non-trivial
> features which are of little use in real life.  Face it: yes it's good
> when you're able to reshape your array online keeping servicing your
> users, but i'd go for even 12 hours downtime if i know my data is safe,
> instead of unknown downtime after I realize the reshape failed for some
> reason and I dont have my data anymore.  And yes it's very rarely used
> (which adds to the problem - rarely used code paths with bugs with stays
> unfound for alot of time, and bite you at a very unexpected moment, when
> you think it's all ok...)

If you look at the amount of code in the 'reshape raid5' patch you
will notice that it isn't really very much.  It reuses a lot of the
infrastructure that is already present in md/raid5.  So a reshape
actually uses a lot of code that is used very often.

Compare this to an offline solution (raidreconfig) where all the code
is only used occasionally.  You could argue that the online version
has more code safety than the offline version....

NeilBrown
