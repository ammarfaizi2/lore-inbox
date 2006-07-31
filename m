Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWGaEYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWGaEYv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 00:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWGaEYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 00:24:51 -0400
Received: from mail.suse.de ([195.135.220.2]:9914 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751463AbWGaEYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 00:24:50 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 31 Jul 2006 14:24:41 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17613.34313.547132.43455@cse.unsw.edu.au>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 008 of 11] knfsd: add svc_set_num_threads
In-Reply-To: message from Andrew Morton on Sunday July 30
References: <20060731103458.29040.patches@notabene>
	<1060731004223.29267@suse.de>
	<20060730211130.be44c1d0.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday July 30, akpm@osdl.org wrote:
> On Mon, 31 Jul 2006 10:42:23 +1000
> NeilBrown <neilb@suse.de> wrote:
> 
> > +	/* destroy old threads */
> > +	while (nrservs < 0 &&
> > +	       (victim = choose_victim(serv, pool, &state)) != NULL) {
> > +		send_sig(serv->sv_kill_signal, victim, 1);
> > +		nrservs++;
> 
> Using signals to communicate with kernel threads is rather baroque - we
> have a range of less klunky ways of controlling kernel threads in-kernel.

True.

> 
> The containers guys are going through converting lots of these things over
> to the kthread API - I believe it's a requirement for containerisation.
> 

Yes - hch has suggested that this needs to be a done.  I had a try and
there were enough complications that I decided to leave it to asked
Greg's NUMA stuff.

> nfsd/rpc is going to be one of the hard ones to convert, but it's going to
> happen.

yep.

NeilBrown
