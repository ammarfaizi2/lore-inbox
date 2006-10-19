Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946117AbWJSPcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946117AbWJSPcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 11:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946120AbWJSPcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 11:32:41 -0400
Received: from smtp151.iad.emailsrvr.com ([207.97.245.151]:3524 "EHLO
	smtp151.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S1946117AbWJSPck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 11:32:40 -0400
Subject: Re: Unnecessary BKL contention in video1394
From: Daniel Drake <ddrake@brontes3d.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Andi Kleen <ak@suse.de>, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <45378D59.4060200@s5r6.in-berlin.de>
References: <1161203487.28713.8.camel@systems03.lan.brontes3d.com>
	 <45369E69.30007@s5r6.in-berlin.de>
	 <1161263978.2845.6.camel@systems03.lan.brontes3d.com>
	 <200610191527.42802.ak@suse.de>  <45378D59.4060200@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 11:31:01 -0400
Message-Id: <1161271861.2845.12.camel@systems03.lan.brontes3d.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 16:36 +0200, Stefan Richter wrote:
> Thanks for the info. Daniel, do you want to resend a signed-off patch?
> And __video1394_ioctl and its wrapper video1394_ioctl can certainly be
> merged then.

Yep, I had already made that change locally. I will run it overnight on
several cameras just to be sure, and will send a patch tomorrow.

I also did some more investigation and straightened out my knowledge of
file_operations: release() can never be called while inside a read() or
ioctl(): This would imply that separate threads are in use, and the
driver's release() function is not called until *all* threads have
closed the fd.  In other words I'm now much more confident that this
patch is not removing any necessary locking.

Daniel


