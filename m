Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423370AbWJURnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423370AbWJURnw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 13:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423369AbWJURnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 13:43:52 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:48846 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1423367AbWJURnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 13:43:51 -0400
Message-ID: <453A5C9E.1070303@candelatech.com>
Date: Sat, 21 Oct 2006 10:45:02 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: futex hang with rpm in 2.6.17.1-2174_FC5
References: <453917C2.8010201@candelatech.com> <20061021052423.GF21948@redhat.com>
In-Reply-To: <20061021052423.GF21948@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Fri, Oct 20, 2006 at 11:38:58AM -0700, Ben Greear wrote:
>  > I had a dead nfs server that was causing some programs to pause,
>  > in particular 'yum install foo' was paused.  I kill -9'd the
>  > yum related processes.
>  > 
>  > I fixed up the nfs server and was able to un-mount the file system.
>  > I subsequently killed many backed up updatedb and similar processes.
>  > 
>  > Now, there are no rpm processes, but if I try 'rpm [anything]' it
>  > hangs trying to open a futex:
>  > 
>  > open("/var/lib/rpm/Packages", O_RDONLY|O_LARGEFILE) = 4
>  > fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
>  > fstat64(4, {st_mode=S_IFREG|0644, st_size=41390080, ...}) = 0
>  > futex(0xb7ba178c, FUTEX_WAIT, 1, NULL <unfinished ...>
>  > 
>  > Is there any way to figure out what is causing this futex-wait?
>
> The dead rpm you killed left behind locks in its databases.
> rm -f /var/lib/rpm/__db* and it should work again.
>   
I'll give that a try, but shouldn't these locks clean themselves up when the
process is killed or shouldn't rpm notice the previous process is dead and
clean it up itself?

Thanks,
Ben

> 	Dave
>
>   


-- 
Ben Greear <greearb@candelatech.com> 
Candela Technologies Inc  http://www.candelatech.com


