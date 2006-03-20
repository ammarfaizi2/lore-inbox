Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWCTOOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWCTOOP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 09:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWCTOOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 09:14:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:11441 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964773AbWCTOOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 09:14:14 -0500
Subject: Re: [3/3 PATCH] Kprobes: User space probes support- single
	stepping out-of-line
From: Arjan van de Ven <arjan@infradead.org>
To: prasanna@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, ak@suse.de, davem@davemloft.net,
       suparna@in.ibm.com, richardj_moore@uk.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060320140503.GB18975@in.ibm.com>
References: <20060320060745.GC31091@in.ibm.com>
	 <20060320060931.GD31091@in.ibm.com> <20060320061014.GE31091@in.ibm.com>
	 <20060320061123.GF31091@in.ibm.com> <20060320030922.4ea9445b.akpm@osdl.org>
	 <1142853841.3114.27.camel@laptopd505.fenrus.org>
	 <20060320140503.GB18975@in.ibm.com>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 15:13:48 +0100
Message-Id: <1142864028.3114.51.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-20 at 19:35 +0530, Prasanna S Panchamukhi wrote:
> On Mon, Mar 20, 2006 at 12:24:01PM +0100, Arjan van de Ven wrote:
> > 
> > Lines: 16
> > 
> > > And we'll need to actually *be* in-atomic.  That means we need an
> > > open-coded inc_preempt_count() and dec_preempt_count() in there and I don't
> > > see them.
> > > 
> > 
> > ..
> > 
> > > Why is VM_LOCKED being set? (It needs a comment).
> > > 
> > > Where does it get unset?
> > 
> > 
> > if this is an attempt to make the copy_in_atomic to be atomic, then it
> > is a bug; the user can unset this bit after all via mprotect, even from
> > another thread, and concurrently. U
> 
> You are right, the purpose was to make copy_to_user_inatomic() to suceed. I
> need to look at this issue again. Any suggestions?

get_user_pages seems to be the only viable API for this..


