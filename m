Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161186AbWGNCqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161186AbWGNCqd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 22:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161197AbWGNCqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 22:46:33 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:56031 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161186AbWGNCqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 22:46:32 -0400
Date: Thu, 13 Jul 2006 19:46:09 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: arjan@infradead.org, torvalds@osdl.org, penberg@cs.helsinki.fi,
       mingo@elte.hu, sekharan@us.ibm.com, linux-kernel@vger.kernel.org,
       nagar@watson.ibm.com, balbir@in.ibm.com
Subject: Re: [patch] lockdep: annotate mm/slab.c
In-Reply-To: <Pine.LNX.4.64.0607131929050.31444@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0607131944260.31824@schroedinger.engr.sgi.com>
References: <1152763195.11343.16.camel@linuxchandra> <20060713071221.GA31349@elte.hu>
 <20060713002803.cd206d91.akpm@osdl.org> <20060713072635.GA907@elte.hu>
 <20060713004445.cf7d1d96.akpm@osdl.org> <20060713124603.GB18936@elte.hu>
 <84144f020607130858l60792ac0t5f9cdabf1902339c@mail.gmail.com>
 <Pine.LNX.4.64.0607131156060.5623@g5.osdl.org> <1152818472.3024.75.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0607131543040.30558@schroedinger.engr.sgi.com>
 <20060713161620.f61d2ac0.akpm@osdl.org> <Pine.LNX.4.64.0607131929050.31444@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could we please remove the fake revert from the git tree immediately?

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=fc818301a8a39fedd7f0a71f878f29130c72193d

2.6.17 code has also the dropping of the lock. This was no reversion. 
Maybe there is a problem but then I'd like to hear about it:

               /* fixup slab chains */
                if (slabp->inuse == 0) {
                        if (l3->free_objects > l3->free_limit) {
                                l3->free_objects -= cachep->num;
                                /*
                                 * It is safe to drop the lock. The slab is
                                 * no longer linked to the cache. cachep
                                 * cannot disappear - we are using it and
                                 * all destruction of caches must be
                                 * serialized properly by the user.
                                 */
                                spin_unlock(&l3->list_lock);
                                slab_destroy(cachep, slabp);
                                spin_lock(&l3->list_lock);
                        } else {
                                list_add(&slabp->list, &l3->slabs_free);
                        }

