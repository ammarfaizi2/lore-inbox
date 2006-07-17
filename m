Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWGQJ0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWGQJ0f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 05:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWGQJ0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 05:26:35 -0400
Received: from [216.208.38.107] ([216.208.38.107]:31104 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S1750718AbWGQJ0f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 05:26:35 -0400
Subject: Re: lockdep warning when nesting dm devices
From: Arjan van de Ven <arjan@linux.intel.com>
To: Alasdair G Kergon <agk@redhat.com>
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, Ingo Molnar <mingo@elte.hu>,
       Milan Broz <mbroz@redhat.com>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
In-Reply-To: <20060717024519.GA26318@agk.surrey.redhat.com>
References: <m34pxj6rsm.fsf@telia.com>
	 <20060717024519.GA26318@agk.surrey.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 17 Jul 2006 11:16:28 +0200
Message-Id: <1153127808.3062.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-17 at 03:45 +0100, Alasdair G Kergon wrote:
> On Sat, Jul 15, 2006 at 01:17:29PM +0200, Peter Osterlund wrote:
> > # echo "0 10000 linear /dev/loop0 0" | /sbin/dmsetup create test
> > # echo "0 10000 linear /dev/mapper/test 0" | /sbin/dmsetup create test2
>  
> > I get the following warning from the lockdep validator.
> > =============================================
> > [ INFO: possible recursive locking detected ]
> > ---------------------------------------------
> 
> Well at first sight the message is simply pointing out something expected - it
> only say "INFO" after all - viz. recursive use of
> 	down_read(&md->io_lock);

is this indeed the same io_lock? Because if it is it's a serious
deadlock; rwsem's are NOT self-recursive!
