Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWFZRYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWFZRYY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWFZRYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:24:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53438 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751153AbWFZRYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 13:24:23 -0400
Date: Mon, 26 Jun 2006 10:24:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com
Cc: Mike.Miller@hp.com, ebiederm@xmission.com, maneesh@in.ibm.com,
       Neela.Kolli@engenio.com, linux-scsi@vger.kernel.org,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [RFC] [PATCH 2/2] kdump: cciss driver initialization
 issue fix
Message-Id: <20060626102410.52070d7e.akpm@osdl.org>
In-Reply-To: <20060626170440.GF8985@in.ibm.com>
References: <m1lkrjub2m.fsf@ebiederm.dsl.xmission.com>
	<E717642AF17E744CA95C070CA815AE550E1555@cceexc23.americas.cpqcorp.net>
	<20060626170440.GF8985@in.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2006 13:04:40 -0400
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> > Thanks Eric, that helps me understand. Section 8.2.2 of the open cciss
> > spec supports a reset message. Target 0x00 is the controller. We could
> > add this to the init routine to ensure the board is made sane again but
> > this would drastically increase init time under normal circumstances.
> > And I suspect this is a hard reset, also. Not sure if that would
> > negatively impact kdump. If there were some condition we could test
> > against and perform the reset when that condition is met it would not
> > impact 99.9% of users.
> 
> That's the precise reason of introducing the "crashboot" command line
> parameter. Driver authors can check against this condition and reset
> the device and 99.9% of the users are not impacted.

Yes, that is a legitimate use.

As long as there is indeed a noticeable downside to issuing the reset - if
it turns out that it just takes a few milliseconds then we'd be better off
dong the reset unconditionally.

