Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVBQWzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVBQWzk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 17:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVBQWzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 17:55:01 -0500
Received: from mail.tmr.com ([216.238.38.203]:57861 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261222AbVBQWxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 17:53:36 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX
 as device
Date: Thu, 17 Feb 2005 17:58:05 -0500
Organization: TMR Associates, Inc
Message-ID: <cv36kk$54m$1@gatekeeper.tmr.com>
References: <200502152125.j1FLPSvq024249@turing-police.cc.vt.edu> <200502161736.j1GHa4gX013635@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1108680149 5270 192.168.12.100 (17 Feb 2005 22:42:29 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <200502161736.j1GHa4gX013635@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Wed, 16 Feb 2005 10:42:21 +0100, "Kiniger, Karl (GE Healthcare)" said:
> 
> 
>>>   Have you tested the ISO on some *OTHER* hardware?  The impression I got
>>>   was that the cd was *burned* right by ide-cd, but when *read back*, it
>>>   bollixed things up at the end of the CD.....
>>
>>Using ide-scsi is enough to get all the data till the real end of the CD.
> 
> 
> OK, so the problem is that ide-cd is able to *burn* the CD just fine, but it
> suffers lossage when ide-cd tries to read it back...
> 
> Alan - are the sense-byte patches for ide-cd in a shape to push either upstream
> or to -mm?

The last time I looked at this, the issue was that the user software did 
a large read and the ide-cd didn't properly return a small data block 
with no error, but rather returned an error with no data. If you get the 
size of the ISO image, you can read that with any program which doesn't 
try to read MORE than that.

I don't consider this correct behaviour, but at least I know how to get 
by it for iso-9660 CDs. For other formats which don't allow 
determination of data set size except by the contents of the data, this 
works poorly.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
