Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276786AbRJHJDf>; Mon, 8 Oct 2001 05:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276775AbRJHJDZ>; Mon, 8 Oct 2001 05:03:25 -0400
Received: from cs6625186-50.austin.rr.com ([66.25.186.50]:128 "EHLO
	hatchling.taral.net") by vger.kernel.org with ESMTP
	id <S276824AbRJHJDS> convert rfc822-to-8bit; Mon, 8 Oct 2001 05:03:18 -0400
Date: Mon, 8 Oct 2001 04:03:48 -0500
From: Taral <taral@taral.net>
To: linux-kernel@vger.kernel.org
Subject: [BUG] Missing wake_up in drivers/scsi/sg.c
Message-ID: <20011008040348.A2857@taral.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/sg.c:319 (sg_open) (2.4.10-ac4) reads:

    if (flags & O_EXCL) sdp->exclude = 0; /* undo if error */

but this variable is linked to a waitlist. Should this not read thus?

    if (flags & O_EXCL) {
        sdp->exclude = 0;
        wake_up_interruptible(&sdp->o_excl_wait);
    }

It reads this way in sg_release.

-- 
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Any technology, no matter how primitive, is magic to those who don't
understand it." -- Florence Ambrose
