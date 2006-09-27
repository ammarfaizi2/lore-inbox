Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWI0OE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWI0OE5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 10:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWI0OE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 10:04:57 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:4769 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932251AbWI0OE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 10:04:56 -0400
Date: Wed, 27 Sep 2006 15:57:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Srinivasa Ds <srinivasa@in.ibm.com>
Cc: dm-devel@redhat.com, linux-lvm@redhat.com, linux-kernel@vger.kernel.org,
       agk@redhat.com
Subject: Re: [RFC] Reverting "bd_mount_mutex" to "bd_mount_sem"
Message-ID: <20060927135705.GA30311@elte.hu>
References: <451A78DF.1060901@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451A78DF.1060901@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Srinivasa Ds <srinivasa@in.ibm.com> wrote:

>   On debugging I found out that,"dmsetup suspend <device name>" calls 
> "freeze_bdev()",which locks "bd_mount_mutex" to make sure that no new 
> mounts happen on bdev until thaw_bdev() is called.
>   This "thaw_bdev()" is getting called when we resume the device 
> through "dmsetup resume <device-name>".
>   Hence we have 2 processes,one of which locks 
> "bd_mount_mutex"(dmsetup suspend) and Another(dmsetup resume) unlocks 
> it.

hm, to me this seems quite a fragile construct - even if the 
mutex-debugging warning is worked around by reverting to a semaphore.

	Ingo
