Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUISVPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUISVPb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 17:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUISVPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 17:15:31 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:46779 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264113AbUISVPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 17:15:22 -0400
Message-ID: <414DF773.7060402@myrealbox.com>
Date: Sun, 19 Sep 2004 14:17:39 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: Hans-Frieder Vogt <hfvogt@arcor.de>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, netdev@oss.sgi.com
Subject: Re: 2.6.9-rc1-bk11+ and 2.6.9-rc1-mm3,4 r8169: freeze during boot
 (FIX included)
References: <200409130035.50823.hfvogt@arcor.de> <20040916070211.GA32592@electric-eye.fr.zoreil.com> <200409161320.16526.jdmason@us.ltcfwd.linux.ibm.com> <200409171043.21772.jdmason@us.ltcfwd.linux.ibm.com> <20040917160151.GA29337@electric-eye.fr.zoreil.com>
In-Reply-To: <20040917160151.GA29337@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> Jon Mason <jdmason@us.ibm.com> :
> [...]
> 
>>Before I make any sweeping comments about the performance on ppc64, I should 
>>probably do some more tests.  I'll have to get back to you regarding that.
>>
>>Would you like me to run the "Config2" patch on my amd64 system?
> 
> 
> Please do. If I read you correctly, 2.6.9-rc2-bkX works (more or less)
> on both your ppc64 and amd64 systems, right ?

No, still broken.  But I don't see any change at all in 2.6.9-rc2-bk5. 
This is on amd64, with 32-bit slots (I think).

BTW, the crash is not immediate.  It takes several seconds after trying 
to send/recieve.

I say _trying_ because I can't ping anything.  I haven't had time before 
the crash to figure out what's wrong, but the device at the other end 
does flash that a packet came through the wire.

FWIW, it looks like init_board is setting PCIDAC in tp->cp_cmd but that 
isn't updated to the card until after the rx ring is filled in 
r8169_open.  This seems suspicious, since DMA memory is being allocated 
possibly in >32-bit addresses but the card hasn't been told to support 
that.  Fixing this doesn't seem to help, though...

Turning off high DMA fixes it.  Maybe it just needs to be disabled until 
someone figures out what's going on.

--Andy

