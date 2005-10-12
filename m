Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751543AbVJLUMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbVJLUMV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 16:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbVJLUMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 16:12:21 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:31463 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751542AbVJLUMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 16:12:20 -0400
Date: Wed, 12 Oct 2005 22:12:18 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Jeff Mahoney <jeffm@suse.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
       Glauber de Oliveira Costa <glommer@br.ibm.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH] Use of getblk differs between locations
In-Reply-To: <434D6CFA.4080802@suse.com>
Message-ID: <Pine.LNX.4.62.0510122208210.11573@artax.karlin.mff.cuni.cz>
References: <20051010204517.GA30867@br.ibm.com> 
 <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk> 
 <20051010214605.GA11427@br.ibm.com>  <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>
  <Pine.LNX.4.64.0510102319100.6247@hermes-1.csi.cam.ac.uk> 
 <Pine.LNX.4.62.0510110035110.19021@artax.karlin.mff.cuni.cz>
 <1129017155.12336.4.camel@imp.csi.cam.ac.uk> <434D6932.1040703@suse.com>
 <Pine.LNX.4.62.0510122155390.9881@artax.karlin.mff.cuni.cz> <434D6CFA.4080802@suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Is memory management ready for this? Can't deadlock like this happen?
>> - displaying dialog window needs memory, so it waits until memory will
>> be available
>> - system decides to write some write-back cached data in order to free
>> memory
>> - the write of these data waits until the dialog window is displayed,
>> user inserts the device and clicks 'OK'
>
> No, it's not, and deadlock is definitely possible. However, if we're at
> the point where memory is tight enough that it's an issue, the timer can
> expire and all the pending i/o is dropped just as it would be without
> the multipath code enabled.
>
> I'm not saying it's a solution ready for production, just a good
> starting point.

But discarding data sometimes on USB unplug is even worse than discarding 
data always --- users will by experimenting learn that linux doesn't 
discard write-cached data and reminds them to replug the device --- and 
one day, randomly, they lose their data because of some memory management 
condition...

Mikulas
