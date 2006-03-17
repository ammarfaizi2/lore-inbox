Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932706AbWCQHLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706AbWCQHLZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 02:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752551AbWCQHLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 02:11:25 -0500
Received: from ns2.suse.de ([195.135.220.15]:15511 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752548AbWCQHLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 02:11:24 -0500
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 17 Mar 2006 18:10:04 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17434.24780.264743.119634@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 007 of 13] md: Core of raid5 resize process
In-Reply-To: message from Andrew Morton on Thursday March 16
References: <20060317154017.15880.patches@notabene>
	<1060317044755.16096@suse.de>
	<20060316220322.0cfa80bf.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday March 16, akpm@osdl.org wrote:
> NeilBrown <neilb@suse.de> wrote:
> >
> > @@ -4539,7 +4543,9 @@ static void md_do_sync(mddev_t *mddev)
> >   		 */
> >   		max_sectors = mddev->resync_max_sectors;
> >   		mddev->resync_mismatches = 0;
> >  -	} else
> >  +	} else if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery))
> >  +		max_sectors = mddev->size << 1;
> >  +	else
> >   		/* recovery follows the physical size of devices */
> >   		max_sectors = mddev->size << 1;
> >   
> 
> This change is a no-op.   Intentional?

Uhmm... sort of.
A later patch adds stuff to the later branch but not the middle one.
This comes from creating a patch to fix a bug, then merging it back
into the wrong original patch...

NeilBrown
