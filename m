Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284731AbRLEVNG>; Wed, 5 Dec 2001 16:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284730AbRLEVMr>; Wed, 5 Dec 2001 16:12:47 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:48258 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S284729AbRLEVMi>; Wed, 5 Dec 2001 16:12:38 -0500
Message-ID: <3C0E8DBF.5010000@optonline.net>
Date: Wed, 05 Dec 2001 16:12:31 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net> <3C0D52F1.5020800@optonline.net> <3C0D5796.6080202@redhat.com> <3C0D5CB6.1080600@optonline.net> <3C0D5FC7.3040408@redhat.com> <3C0D77D9.70205@optonline.net> <3C0D8B00.2040603@optonline.net> <3C0D8F02.8010408@redhat.com> <3C0D9456.6090106@optonline.net> <3C0DA1CC.1070408@redhat.com> <3C0DAD26.1020906@optonline.net> <3C0DAF35.50008@redhat.com> <3C0E7DCB.6050600@optonline.net> <3C0E7DFB.2030400@optonline.net> <3C0E7F1C.4060603@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:

> If that fixes it, then the real fix is to find the bug in 
> i810_get_free_Wwrite_space() and i810_update_lvi(). 

It does fix it.

By the way, I'm confused about something. i810_write appears to overrun 
the end of the DMA buffer instead of wrapping around to the beginning 
when it does copy_from_user. which makes no sense to me.

so ok, the correct number is 31/32nds, not 3/4ths - not so bad.

> By using the first function to find the available data in the GETOPTR 
> ioctl, then using update_lvi(), we *should* be setting the lvi 
> fragment to exactly 31 sg segments away from the current index.  If 
> that's failing, and we are instead setting lvi == civ, then things 
> will stop and not work.

yeah, i think that's what's happening

