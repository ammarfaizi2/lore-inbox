Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266517AbUITN2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUITN2i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 09:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266526AbUITN2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 09:28:37 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:12804 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S266517AbUITN2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 09:28:06 -0400
Message-ID: <414EDC0B.3030108@hist.no>
Date: Mon, 20 Sep 2004 15:32:59 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
CC: DervishD <lkml@dervishd.net>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <20040920094602.GA24466@suse.de> <20040920105950.GI5482@DervishD> <414EDA10.7050304@hist.no> <20040920132151.GA30175@suse.de>
In-Reply-To: <20040920132151.GA30175@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:

> On Mon, Sep 20, Helge Hafting wrote:
>
>  
>
>>Using a mtab that is a link to /proc/mounts fails with quota too.
>>Quta tools read /etc/mtab looking for "usrquota" and or "grpquota"
>>mount options.  These appear in a normal /etc/mtab but not in /proc/mounts,
>>    
>>
>
>I have never played with quota. But: does the kernel or a userland tool
>if quota is active for a mount point? smells like a kernel bug.
>  
>
The kernel must know that quota is in use, or it'd be unable to
refuse the syscalls when someone tries to go over his quota.

 From "man mount":
       grpquota / noquota / quota / usrquota
              These  options are accepted but ignored.  (However, quota 
utili‐
              ties may react to such strings in /etc/fstab.)

quota utilities indeed react to such strings in /etc/mtab too.

Qutas aren't actually enabled when the mount options are used,
they are enabled when the "quotaon" tool runs.  I guess it uses
some special syscall or ioctl to really turn quota on.

Doing it at mount time instead, byt actually using those options,
seems saner to me.  But I guess they had their reasons. . .

Helge Hafting


