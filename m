Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269409AbUI3Ss6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269409AbUI3Ss6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 14:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269406AbUI3Ss4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 14:48:56 -0400
Received: from mail.tmr.com ([216.238.38.203]:12295 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S269417AbUI3SsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 14:48:20 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: mmap() on cdrom files fails in 2.6.9-rc2-mmX
Date: Thu, 30 Sep 2004 14:49:32 -0400
Organization: TMR Associates, Inc
Message-ID: <cjhjve$6bv$1@gatekeeper.tmr.com>
References: <20040928214246.41b80d30.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1096569646 6527 192.168.12.100 (30 Sep 2004 18:40:46 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <20040928214246.41b80d30.khali@linux-fr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:
> Hi all,
> 
> (Please CC me on reply, I am not subscribed to the LKML.)
> 
> I think I found a bug in 2.6.9-rc2-mm4. It doesn't seem to be able to
> mmap() files located on cdroms. Same problem with -mm3 and -mm1.
> 2.6.9-rc2 works fine. I reproduced it on two completely different
> systems, so I guess it isn't device dependant.
> 
> I tried to get mmap() to fail on other files with similar properties
> (different owner, read only) but it won't. The problem seems to affect
> only files located on cdroms.
> 
> I also tried on a loop device-mounted cdrom image, in case the problem
> was related to the iso9660 filesystem. The problem wouldn't show. It
> seems to fail only on real cdroms.
> 
> I searched the broken-out directory but wouldn't find any candidate to
> backout.

Is your mmap length a multiple of 2k? If not please resize and try 
again. There is some less traveled code when physical sector size is not 
512 bytes.

Yes, this is a wild guess, but it's easy to test if you have the kernel 
built.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
