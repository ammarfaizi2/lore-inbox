Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWDRBSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWDRBSn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 21:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWDRBSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 21:18:43 -0400
Received: from wproxy.gmail.com ([64.233.184.239]:49624 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932102AbWDRBSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 21:18:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent:sender;
        b=n8JqVUwthgnmApbk2tXe211FzjrpW7yTAq1JAsm+7CKmN5VuefBQ4lRWj/3R6y0caXNX2UlkOJcZpDVuOHaGkq50CFQQOzgMxFXtWNnTESZRFX55fCAGZ+k/8Hi655CtUIdvNU+iI1w6BjVL/st/MEbHuO0nRlG7DTx0hKCPST0=
Date: Mon, 17 Apr 2006 20:18:39 -0500
From: Zinx Verituse <zinx@epicsol.org>
To: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: ide-cd.c, "MEDIUM_ERROR" handling
Message-ID: <20060418011839.GA10619@atlantis.chaos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently bought a DVD drive which appears to not retry enough when it's
having trouble reading a disc - I'm requesting an option (or changing the
default behavior) so that this drive is actually usable with the Linux
ide-cd drivers - specificly, the code:
	} else if (sense_key == MEDIUM_ERROR) {
		/* No point in re-trying a zillion times on a bad
		 * sector...  If we got here the error is not correctable */
		ide_dump_status (drive, "media error (bad sector)", stat);
		do_end_request = 1;
	}
needs to be disabled for my drive to read CDs properly.

With this code enabled, no retries are made, and the kernel sees medium errors
and returns bad data to the application reading; without it, the kernel retries
transparently and reads the data perfectly.  So, I think the comment is
assuming decent hardware, which unfortunately isn't always what we have :/

I can make the patch for conditionally enabling/disabling it if needed.
I think it may make more sense to retry by default, but I don't know the
general state of modern cheap CD/DVD drives either.  It seems like it's
a corner case on hardware that does re-try a zillion times, though, so
probably won't greatly affect that hardware like it does the hardware
that doesn't re-try a zillion times.

I'm not on the list currently, so please CC me with any replies.

-- 
Zinx Verituse                                    http://zinx.xmms.org/
