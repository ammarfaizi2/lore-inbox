Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVBRUW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVBRUW6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 15:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVBRUWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 15:22:43 -0500
Received: from mail.tmr.com ([216.238.38.203]:18184 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261510AbVBRUTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 15:19:16 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX
 as device
Date: Fri, 18 Feb 2005 15:23:44 -0500
Organization: TMR Associates, Inc
Message-ID: <cv5hv3$ana$1@gatekeeper.tmr.com>
References: <cv36kk$54m$1@gatekeeper.tmr.com><cv36kk$54m$1@gatekeeper.tmr.com> <20050218103107.GA15052@wszip-kinigka.euro.med.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1108757284 10986 192.168.12.100 (18 Feb 2005 20:08:04 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <20050218103107.GA15052@wszip-kinigka.euro.med.ge.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kiniger, Karl (GE Healthcare) wrote:
> On Thu, Feb 17, 2005 at 05:58:05PM -0500, Bill Davidsen wrote:
> 
>>Valdis.Kletnieks@vt.edu wrote:
>>
>>>On Wed, 16 Feb 2005 10:42:21 +0100, "Kiniger, Karl (GE Healthcare)" said:
>>>
>>>
>>>
>>>>> Have you tested the ISO on some *OTHER* hardware?  The impression I got
>>>>> was that the cd was *burned* right by ide-cd, but when *read back*, it
>>>>> bollixed things up at the end of the CD.....
>>>>
>>>>Using ide-scsi is enough to get all the data till the real end of the CD.
>>>
>>>
>>>OK, so the problem is that ide-cd is able to *burn* the CD just fine, but 
>>>it
>>>suffers lossage when ide-cd tries to read it back...
>>>
>>>Alan - are the sense-byte patches for ide-cd in a shape to push either 
>>>upstream
>>>or to -mm?
>>
>>The last time I looked at this, the issue was that the user software did 
>>a large read and the ide-cd didn't properly return a small data block 
>>with no error, but rather returned an error with no data. If you get the 
>>size of the ISO image, you can read that with any program which doesn't 
>>try to read MORE than that.
> 
> 
> Not entirely true (at least for me). I actually tried to read the 
> last iso9660 data sector with a small C program (reading 2 kb) and
> it failed to read the sector. Using ide-scsi I was able to read it.....
> 
> sdd (from Joerg Schilling) should not try to read more than ivsize
> bytes (InputVolumeSize) if that argument is given - I did not
> verify with strace though.

I'll try to build a truth table for this, I'm now working with some 
non-iso data sets, so I'm a bit more interested. I would expect read() 
to only try to read one sector, so I'll just do a quick and dirty to get 
the size from the command line, seek and read.

I haven't had a problem using dd to date, as long as I know how long the 
data set was, but I'll try to have results tonight.

Thanks for your additional info on this.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
