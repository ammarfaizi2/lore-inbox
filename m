Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266462AbUAOJgn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 04:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266465AbUAOJgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 04:36:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:21909 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266462AbUAOJgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 04:36:42 -0500
Date: Thu, 15 Jan 2004 10:36:36 +0100
From: Jens Axboe <axboe@suse.de>
To: markw@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 oops w/ reiserfs + deadline elevator
Message-ID: <20040115093636.GJ5507@suse.de>
References: <200401142115.i0ELFDo23784@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401142115.i0ELFDo23784@mail.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14 2004, markw@osdl.org wrote:
> I'm getting the following oops with our DBT-2 workload.  It appears that
> I can only reproduce the problem with a combination of an aacraid
> controller, reiserfs, and the deadline elevator.  I'm also using lvm2
> but I can't really try to do the same test without lvm2 though.  I have
> seen everything behave properly with the AS elevator or without an
> aacraid controller.

I don't believe this has anything to do with the io scheduler, it looks
clearly like a problem deep inside the aac driver (and thus completely
io scheduler independent). The fact that it triggers with deadline is
likely completely coincidental.

Looks like scsicmd->scsi_done == NULL which is very odd. You may want to
try and add some debug prints checking that (and dumping scsicmd state)
fact.

-- 
Jens Axboe

