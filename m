Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWAWP5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWAWP5J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 10:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWAWP5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 10:57:09 -0500
Received: from gate.in-addr.de ([212.8.193.158]:34973 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S1751480AbWAWP5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 10:57:07 -0500
Date: Mon, 23 Jan 2006 16:56:05 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Andrew Morton <akpm@osdl.org>, Alasdair G Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] device-mapper snapshot: barriers not supported
Message-ID: <20060123155605.GP2366@marowsky-bree.de>
References: <20060120211759.GG4724@agk.surrey.redhat.com> <20060122214111.11170cdc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060122214111.11170cdc.akpm@osdl.org>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-01-22T21:41:11, Andrew Morton <akpm@osdl.org> wrote:

> Alasdair G Kergon <agk@redhat.com> wrote:
> >
> > The snapshot and origin targets are incapable of handling barriers and 
> >  need to indicate this.
> > 
> > ...
> >   
> >  +	if (unlikely(bio_barrier(bio)))
> >  +		return -EOPNOTSUPP;
> >  +
> 
> And what was happening if people _were_ sending such BIOs down?  Did it all
> appear to work correctly?  If so, will this change cause
> currently-apparently-working setups to stop working?

Filesystems basically disable using barriers on a device which doesn't
support them, which is indicated by -EOPNOTSUPP. Barriers are allowed to
fail in such fashion.

Now the interesting question is what happens when barriers are suddenly
verboten on a stack which used to support them - because the new mapping
doesn't support it _anymore_. Hrm. _Should_ work, but probably not
tested much ;-)


Sincerely,
    Lars Marowsky-Brée

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

