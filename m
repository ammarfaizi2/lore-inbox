Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315941AbSFDADR>; Mon, 3 Jun 2002 20:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315942AbSFDADQ>; Mon, 3 Jun 2002 20:03:16 -0400
Received: from mail.zianet.com ([204.134.124.201]:32643 "HELO zianet.com")
	by vger.kernel.org with SMTP id <S315941AbSFDADO>;
	Mon, 3 Jun 2002 20:03:14 -0400
Message-ID: <3CFBB151.4070809@zianet.com>
Date: Mon, 03 Jun 2002 12:11:29 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0+) Gecko/20020527
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Steven Timm <timm@fnal.gov>, linux-kernel@vger.kernel.org
Subject: Re: Serverworks OSB4 in impossible state.
In-Reply-To: <Pine.LNX.4.31.0206031234370.12103-100000@boxer.fnal.gov> <1023150548.23874.99.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had this same problem and I posted to the list a couple
of weeks ago but it never got any response.  The only
thing I have on the IDE is a CDROM, rest is SCSI.  I could
mount the CD drive with no problem but once I tried to read
any data from it I would get the 'impossible state' error.  I can
reproduce this at any time, I don't know how the Serverworks
people can't.  Just have them go buy a Dell PowerEdge 1650
and use the CDROM.  This was with 2.4.18.  I found a work
around for it however.  I just turned off DMA and it worked fine
again.  I guess it is turned on by default.  DMA turned off on a
hard drive could suck though, not sure what you could do.

Steven

Alan Cox wrote:

>On Mon, 2002-06-03 at 18:40, Steven Timm wrote:
>  
>
>>Serverworks OSB4 in impossible state.
>>Disable UDMA or if you are using Seagate then try switching disk types
>>on this controller. Please report this event to osb4-bug@ide.cabal.tm
>>OSB4: continuing might cause disk corruption.
>>
>>This is the only one of 60 machines thus configured that has
>>had the error thus far.
>>
>>Two points:
>>1) The E-mail address in that kernel debug message doesn't exist.
>>E-mail bounces back from it.
>>    
>>
>
>Oops I'll go fix that small detail. It should have been forwarded to me.
>
>  
>
>>2) What is causing the hang and are there any hopes to
>>fix it in software this time?  Last year when I came to the kernel
>>list with problems very similar, the consensus was that this
>>is actually broken hardware in the OSB4 chipset...but obviously
>>it is possible for at least some kernels to run quasi-normally
>>on this hardware... what changed between 2.4.9 and 2.4.18 so
>>it doesn't anymore?
>>    
>>
>
>The code traps out when it sees the I/O complete and it turns out that
>the DMA engine flags say the engine is still running. In this state we
>kill the box because we know the next I/O will be written 4 bytes skewed
>with the last 4 bytes of the previous I/O apparently repeated at the
>start.
>
>I took it up with the Serverworks guys at the time, but they were not
>able to duplicate the problem and provide advice. Since we could verify
>this across an entire rendering farm it was clearly not a weird one off
>bug. It also doesn't appear to be a Linux bug (but maybe one day I'll be
>proved wrong).
>
>If you drop the drives to MWDMA2 you'll see only slightly lower
>performance and solid behaviour
>
>Alan
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>



