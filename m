Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267480AbUIUHPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267480AbUIUHPV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 03:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267494AbUIUHPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 03:15:21 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:37899 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S267480AbUIUHPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 03:15:09 -0400
Message-ID: <414FD624.7050603@hist.no>
Date: Tue, 21 Sep 2004 09:20:04 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: Olaf Hering <olh@suse.de>, DervishD <lkml@dervishd.net>,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <20040920094602.GA24466@suse.de> <20040920105950.GI5482@DervishD> <414EDA10.7050304@hist.no> <20040920132151.GA30175@suse.de> <414EDC0B.3030108@hist.no> <20040920141256.GB601@MAIL.13thfloor.at>
In-Reply-To: <20040920141256.GB601@MAIL.13thfloor.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:

>On Mon, Sep 20, 2004 at 03:32:59PM +0200, Helge Hafting wrote:
>  
>
>>Olaf Hering wrote:
>>
>>    
>>
>>>On Mon, Sep 20, Helge Hafting wrote:
>>>
>>>      
>>>
>>>>Using a mtab that is a link to /proc/mounts fails with quota too.
>>>>Quta tools read /etc/mtab looking for "usrquota" and or "grpquota"
>>>>mount options.  These appear in a normal /etc/mtab but not in 
>>>>/proc/mounts,
>>>>        
>>>>
>>>I have never played with quota. But: does the kernel or a userland tool
>>>if quota is active for a mount point? smells like a kernel bug.
>>>      
>>>
>
>- to make the quota active (enable it), the mount option
>  is required
>
>- to display an enabled quota as mount option, the quota
>  on that 'mount point' has to be enabled 
>
>chicken egg thing, eh?
>  
>
Chicken egg by design perhaps, but I can't see
why it have to be that way.

>besides that, not every mountpoint can support quota
>and quota should (must) not be enabled at mount time
>because before the quota is enabled, the quota hash
>has to be initialized to the current usage ...
>  
>
A better way:
Enable the quota at mount time.  If the system isn't ready
for that, i.e. the quota files aren't created/updated - then
refuse the mount.  (Alternatively, mount without quota and
log a complaint.) The administrator can then mount
without quota, run checkquota, and  mount /fs -o remount,usrquota
to turn quota on.

In other words:
quotaon becomes mount -o remount,usrquota
quotaoff becomes mount -o remount,nousrquota
(And/or grpquota of course)

Does it have to be any more complicated than that?


>>Doing it at mount time instead, byt actually using those options,
>>seems saner to me.  But I guess they had their reasons. . .
>>    
>>
>
>yes, quota calculation, see above ...
>  
>
What I don't get is why we have to mount with quota options
that aren't acutally used, and then turn quota on.
Why not mount without quota, and then remount with
quota options when enabling quota for the first time?

The common case should be a fs that was shut down
cleanly and was mounted with quota the last time it
was used.  So it should be able to mount directly
with quota on, because all the on-disk quota information
is valid and up to date.

Helge Hafting


