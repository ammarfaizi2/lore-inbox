Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135203AbRD0Pdl>; Fri, 27 Apr 2001 11:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135974AbRD0Pdb>; Fri, 27 Apr 2001 11:33:31 -0400
Received: from betty.magenta-netlogic.com ([193.37.229.181]:7176 "HELO
	betty.magenta-netlogic.com") by vger.kernel.org with SMTP
	id <S135203AbRD0PdR>; Fri, 27 Apr 2001 11:33:17 -0400
Message-ID: <3AE9913B.6090208@magenta-netlogic.com>
Date: Fri, 27 Apr 2001 16:33:15 +0100
From: Tony Hoyle <tmh@magenta-netlogic.com>
Organization: Magenta Logic
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.8.1+) Gecko/20010423
X-Accept-Language: en
MIME-Version: 1.0
To: jason <jason@lacan.dabney.caltech.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel panic with 2.4.x and reiserfs
In-Reply-To: <Pine.LNX.4.10.10104270104010.7570-100000@lacan.dabney.caltech.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jason wrote:

> Hello,
> 
> As the subject would imply, I've been having problems with 2.4.x. I have
> my root partition (/dev/hda1) as reiserfs and also have another harddrive
> with a reiserfs partition (/dev/hdc1). Several programs write (e.g. save
> files to) /dev/hdc1, and I also store files there. Under 2.4.2, whenever
> manually copying files from hda1 to hdc1, I would get a kernel panic, the


Reiserfs doesn't cope well with crashes....  Under 2.4 I wouldn't 
recommend using it on any kind of critical server - it seems to 
progressively corrupt itself (I'm looking at the second reformat and 
reinstall in a week, and I'm not a happy bunny).

As the warning on reiserfsck says, the rebuild-tree option is a last 
resort.  It's as likely to make the problem worse then improve it (It 
rounds all the file lengths up to a block size, padding with zeros, 
which breaks lots of stuff).  Backup what you can first.

I find that if you run reiserfsck -x /dev/hda1 a couple of dozen times 
it slowly fixes stuff that it couldn't fix on the previous pass.One 
thing that can't fix is the bug that seems to make random files on the 
FS unreadable even for root.The only way I've found around that one is a 
periodic format/reinstall.

Tony

-- 
Where a calculator on the ENIAC is equpped with 18,000 vaccuum
tubes and weighs 30 tons, computers in the future may have only
1,000 vaccuum tubes and perhaps weigh 1 1\2 tons.
-- Popular Mechanics, March 1949

tmh@magenta-netlogic.com


