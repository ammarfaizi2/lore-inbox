Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283535AbRLDWaX>; Tue, 4 Dec 2001 17:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283551AbRLDWaO>; Tue, 4 Dec 2001 17:30:14 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:29056 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S283535AbRLDWaC>; Tue, 4 Dec 2001 17:30:02 -0500
Message-ID: <3C0D4E62.4010904@optonline.net>
Date: Tue, 04 Dec 2001 17:29:54 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:

> Probably not.  Although I did change it back but then change it in 
> another way.  Use the attached patch to back out those changes and let 
> me know if it works (for some reason, I doubt it).

Fascinating...

Your patch to i810_poll fixes the sleep of death. and with the rest of 
the patches in 0.07, select() works a lot better but still not perfectly.

xmms+artsd is likely to play sound for quite a while, *until* I do 
something that causes another process to be scheduled, like click on the 
Mozilla window that's sitting in the background. At that point, it 
reverts to the behavior where select() doesn't return properly. And 
stays that way.

this may be due to an output underrun... or i suppose lost interrupt is 
also possible.

i think it might be wise to use 
get_available_read_data/get_free_write_space from i810_poll instead of 
dmabuf->count directly. i'll try this and see if it works...

