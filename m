Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263977AbTBNSQP>; Fri, 14 Feb 2003 13:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263991AbTBNSQP>; Fri, 14 Feb 2003 13:16:15 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:14006 "EHLO w-patman.des")
	by vger.kernel.org with ESMTP id <S263977AbTBNSQN>;
	Fri, 14 Feb 2003 13:16:13 -0500
Date: Fri, 14 Feb 2003 10:17:44 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: steve cameron <steve.cameron@hp.com>, linux-kernel@vger.kernel.org
Subject: Re: Accessing the same disk via multiple channels
Message-ID: <20030214101744.A25645@beaverton.ibm.com>
References: <20030214032012.GA5481@zuul.cca.cpqcorp.net> <20030214162722.GB11209@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030214162722.GB11209@marowsky-bree.de>; from lmb@suse.de on Fri, Feb 14, 2003 at 05:27:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 05:27:22PM +0100, Lars Marowsky-Bree wrote:

> Indeed. Yes, we'll need to figure out how to do this for 2.5/2.6; maybe
> porting forward the md m-p patch to 2.5 is indeed the best choice. It should
> be way easier, as md has been greatly cleaned up...

> However, past discussions on LKML regarding "How to do m-p cleanly in 2.5"
> have never reached a conclusion ;-) We'll see. The good thing about the SCSI
> m-p is that it can also handle multipathed tape drives...

I thought the general consensus was it is OK for now (as a first go) to
have scsi only multi-path, I have not heard anyone say don't do scsi
multi-path. And then later (maybe after we have more than one subsystem
supporting multi-path IO) we can add general multi-path support into the
layers above scsi.

In any case, md or volume manager based multi-path solutions are good
alternatives.

I have recently ported the scsi multi-path patch to 2.5.59, but haven't
posted patches.

The current multi-path patch still needs at least two major changes in
scsi: error recovery (scsi_error.c) that allows other paths to be used
without long delays, and a per-device queue_lock versus the current
per-host queue_lock.

Hopefully we can get underlying changes for those last two into 2.5 (and
maybe someday the multi-path patch), as they are improvements to scsi with
or without multi-path.

-- Patrick Mansfield
