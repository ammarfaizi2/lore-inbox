Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWAYOnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWAYOnp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 09:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWAYOnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 09:43:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:1327 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751180AbWAYOnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 09:43:45 -0500
Date: Wed, 25 Jan 2006 15:45:44 +0100
From: Jens Axboe <axboe@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Albert Cahalan <acahalan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, schilling@fokus.fraunhofer.de,
       matthias.andree@gmx.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060125144543.GY4212@suse.de>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25 2006, Jan Engelhardt wrote:
> 
> >> Where is the difference between SG_IO-on-hdx and sg0?
> >
> >It's like the /dev/ttyS* and /dev/cua* situation, where
> >we also ended up with multiple device files. This is bad.
> >
> >SG_IO-on-hdx is modern. It properly associates everything
> >with one device, which you may name as desired.
> 
> Let's analyze a case:
> if /dev/sg0 would always be associated with /dev/hda,
> /dev/sg1 always with /dev/hdb, no matter if there was actually a
> hda/sg0 device present in the system - would that simplify
> the problem?

Forget /dev/sg0, it's meaningless and confusing to try and bind two
unrelated names to each other. You want to talk to /dev/hda, use
/dev/hda. Don't try and create a pseudo mapping between the two. That's
also where cdrecord gets it wrong on Linux - you don't need -scanbus. If
users think they do, it's either because Joerg brain washed them or
because they have been used to that bad interface since years ago when
it was unfortunately needed.

-- 
Jens Axboe

