Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUCSAeX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 19:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbUCSAaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 19:30:15 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:38790 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S263166AbUCSA3z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 19:29:55 -0500
Message-ID: <405A4015.40108@tmr.com>
Date: Thu, 18 Mar 2004 19:34:29 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Diego_Calleja_Garc=EDa?= <diegocg@teleline.es>
CC: Rik van Riel <riel@redhat.com>, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-aa1
References: <Pine.LNX.4.44.0403181144290.16728-100000@chimarrao.boston.redhat.com> <20040318211532.293bb63c.diegocg@teleline.es>
In-Reply-To: <20040318211532.293bb63c.diegocg@teleline.es>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja García wrote:
> El Thu, 18 Mar 2004 11:49:52 -0500 (EST) Rik van Riel <riel@redhat.com> escribió:
> 
> 
>>I suspect the security paranoid will like this patch too,
>>because it allows gnupg to mlock the memory it wants to
>>have locked.
> 
> 
> I think it's good for cd-burning too. Currently most of the distros set
> the suid bit for cdrecord (wich implies some security bugs). You can
> workaround that by changing the devide node's permissions and kill the suid bit:
> brw-rw----    1 root     burning     22,   0 2003-05-23 16:41 /dev/cd-rw
> 
> but still cdrecord will cry:
> cdrecord: Operation not permitted. WARNING: Cannot do mlockall(2).
> cdrecord: WARNING: This causes a high risk for buffer underruns.
> 
> With that patch desktop users will be able to burn cds without falling into
> buffer underruns and without using the suid hack, I guess? Nice work :)

Have a bit of caution there, cdrecord sets itself realtime priority, 
locks pages in memory, and ensures that the process is likely to work 
even under load. I don't think addressing just a part of the problem 
will result in reliability under load. You would have to look at 
capabilities to allow these things to be done, under load they may not 
keep up depending on what's going on. Good to get a start, don't assume 
all the issues are addressed.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
