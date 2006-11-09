Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423951AbWKIARw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423951AbWKIARw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 19:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423952AbWKIARw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 19:17:52 -0500
Received: from mail.suse.de ([195.135.220.2]:26063 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1423950AbWKIARv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 19:17:51 -0500
From: Neil Brown <neilb@suse.de>
To: Kay Sievers <kay.sievers@vrfy.org>
Date: Thu, 9 Nov 2006 11:17:57 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17746.29621.106336.339322@cse.unsw.edu.au>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001 of 6] md: Send online/offline uevents when an md
	array starts/stops.
In-Reply-To: message from Kay Sievers on Wednesday November 8
References: <20061031164814.4884.patches@notabene>
	<1061031060046.5034@suse.de>
	<20061031211615.GC21597@suse.de>
	<3ae72650611020413q797cf62co66f76b058a57104b@mail.gmail.com>
	<17737.58737.398441.111674@cse.unsw.edu.au>
	<1162475516.7210.32.camel@pim.off.vrfy.org>
	<17738.59486.140951.821033@cse.unsw.edu.au>
	<1162542178.14310.26.camel@pim.off.vrfy.org>
	<17742.32612.870346.954568@cse.unsw.edu.au>
	<1162984482.16735.25.camel@pim.off.vrfy.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday November 8, kay.sievers@vrfy.org wrote:
> 
> Is there a sysfs file or something similar(we could also call a md-tool)
> udev could look at, before it tries to open the device? Like:
>   KERNEL=="md*", ATTR{state}=="active", IMPORT{program}= ...

If the /sys/block/mdX directory exists at all, it is safe to open the
device-special file.  But that is racy.  It could disappear between
checking that the dir exists, and opening the device-special-file.

I still think it would make SO much sense if /sys/block/md4/dev were a
device-special-file instead of a (silly) ascii file with 9:4.  Then
this race could be closed.  But I feel that is a battle I've never
going to win.

You could look at /sys/block/mdX/md/array_state.  If that contains
'clean' or 'inactive' then there is no point opening the device.
Otherwise there might be a point, and the race would be a lot harder
to lose.

I guess it is time for me to learn about udev config files...

NeilBrown
