Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267860AbUJCM0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267860AbUJCM0V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 08:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267863AbUJCM0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 08:26:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:11942 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267860AbUJCM0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 08:26:19 -0400
Date: Sun, 3 Oct 2004 14:23:33 +0200
From: Jens Axboe <axboe@suse.de>
To: jmerkey@comcast.net
Cc: linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: 2.6.9-rc2-mm4 BIO's still broken
Message-ID: <20041003122333.GI2296@suse.de>
References: <100120041714.26442.415D9057000F388B0000674A2200734840970A059D0A0306@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <100120041714.26442.415D9057000F388B0000674A2200734840970A059D0A0306@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(please wrap your out going emails, the lines are way too long)

On Fri, Oct 01 2004, jmerkey@comcast.net wrote:
> 
> I have more information on the problem with bio requests.  I am seeing
> the bi_size value return through bi_end_io early with an odd size if
> the interface is passed an unaligned 4K write.  What's busted here is
> that bio_add_page accepts the 4K unaligned write request, then the
> callback from the SCSI layer calls back with a partial compleation
> with the bi_size field set to the value of 0x1FE (????) and no other
> callback is received.  What's busted here is if you use the
> recommended logic of 
> 
> if (bio->bi_size) return 1;
> 
> then you never get the completed callback and the IO request just sits
> off in left field and the driver never returns any error status
> through the callback interface.  I am also still seeing the
> disappearing pages and after tracking through the code, I am certain
> they are related since I am not getting any callbacks from the driver
> layer after I receive the first end_io callback with bi_size set.  

Please send a test case, thanks.

-- 
Jens Axboe

