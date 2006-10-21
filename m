Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423374AbWJUSHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423374AbWJUSHa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 14:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423375AbWJUSHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 14:07:30 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:50664 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1423374AbWJUSHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 14:07:30 -0400
Message-ID: <453A622C.2020401@candelatech.com>
Date: Sat, 21 Oct 2006 11:08:44 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: futex hang with rpm in 2.6.17.1-2174_FC5
References: <453917C2.8010201@candelatech.com> <20061021052423.GF21948@redhat.com> <453A5C9E.1070303@candelatech.com> <20061021180005.GF30758@redhat.com>
In-Reply-To: <20061021180005.GF30758@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Sat, Oct 21, 2006 at 10:45:02AM -0700, Ben Greear wrote:
>  > Dave Jones wrote:
>  > > On Fri, Oct 20, 2006 at 11:38:58AM -0700, Ben Greear wrote:
>  > >  > I had a dead nfs server that was causing some programs to pause,
>  > >  > in particular 'yum install foo' was paused.  I kill -9'd the
>  > >  > yum related processes.
>  > >  > 
>  > > The dead rpm you killed left behind locks in its databases.
>  > > rm -f /var/lib/rpm/__db* and it should work again.
>  > >   
>  > I'll give that a try, but shouldn't these locks clean themselves up when the
>  > process is killed
>
> If you kill -9'd the processes, what do you expect to do
> the clean up work ?
>   

Well, you can do tricks with file handles so that they are automatically 
closed/deleted when
a process exits, even with kill -9.  Since this lock is evidently 
something in the kernel (since the kernel
call is blocking), then it seems like a similar trick could be crafted.

>  > or shouldn't rpm notice the previous process is dead and
>  > clean it up itself?
>  
> Sounds sensible to me and you, but in the past sensible ideas and
> rpm maintainers haven't gone hand in hand.
>   
Ahhh :)

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com> 
Candela Technologies Inc  http://www.candelatech.com


