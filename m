Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbVJaREg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbVJaREg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 12:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbVJaREg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 12:04:36 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:4079 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932474AbVJaREf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 12:04:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=GqWBQtmfsptd2v2Zvo5obJKLqPp8YGjigCoQ/SDIhkP6c8EQ8ZC+jg/kfo39PuC+1i7rvzfDWroktJIun2C26BfEtmUnW047qB7owVGreGZfG+6RlZF6rZlmhc05FUxhhUq7r0IBQZfnDMC0lM5n/QPpyG4mVxtkruhfxvWs6LA=
Message-ID: <43664E9C.2030808@gmail.com>
Date: Mon, 31 Oct 2005 18:04:28 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051027)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: ray-gmail@madrabbit.org, "Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2579] linux 2.6.* sound problems
References: <53JVy-4yi-19@gated-at.bofh.it> <53Kyw-5Bt-53@gated-at.bofh.it>
In-Reply-To: <53Kyw-5Bt-53@gated-at.bofh.it>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Lee ha scritto:
> On 10/31/05, Patrizio Bassi <patrizio.bassi@gmail.com> wrote:
> 
>>starting from 2.6.0 (2 years ago) i have the following bug.
> 
> 
> Well, the problem probably started before then.
> 
> 
>>link: http://bugzilla.kernel.org/show_bug.cgi?id=2579
> 
> 
>>Please fix that...2 years' bug!
> 
> 
> Speaking as a programmer, that's not a lot to go off of to find the
> bug. I think everyone would agree it's a bug, but we'll need more help
> from you.
> 
> 
>>fast summary:
>>when playing audio and using a bit the harddisk (i.e. md5sum of a 200mb
>>file) i hear noises, related to disk activity. more hd is used, more chicks
>>and ZZZZ noises happen.
> 
> 
> Does hdparm -i (or -I) show differences between the 2.4 kernels and
> 2.6? 2.6 has new IDE drivers, and so perhaps your system isn't using
> the best driver any more.
> 
> You may also want to compare lspci -vv of your IDE controller and
> sound card between 2.4 and 2.6, and see if there are any differences.
> 
> No guarantees, but this is where you'd start.
> 
> 
>>Ready to test any patch/solution.
> 
> 
> Try that. If nothing obvious appears in the examination, you may want
> to try the 2.6.14-rt1 patchset from Ingo Molnar. It's designed to
> reduce latency in the kernel, but also has a latency tracer that may
> be particularly useful for your problem. (Assuming it's a latency
> issue, and not a hardware misconfiguration due to 2.6 doing something
> wrong.)
> 
> Ray

actually i don't have any more 2.4 kernels due to some problems with
other devices.

however i remember i checked that and it was pretty the same

i know i gave you all few infos, but, ask me and i'll try more.

i have an intel bx440 chipset, udma33.

kernel is perfectly tuned.

i notice that with dma disabled it works much better.
problem happens with hda/hdc, so both ide channels.




hdparm -i /dev/hda

/dev/hda:

 Model=IBM-DTLA-307030, FwRev=TX4OA50C, SerialNo=YKDYKV9J094
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=60036480
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:

 * signifies the current active mode

 hdparm -i /dev/hdc

/dev/hdc:

 Model=IC35L060AVV207-0, FwRev=V22OA63A, SerialNo=VNVB07G2RJ2X4M
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=52
 BuffType=DualPortCache, BuffSize=1821kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=120103200
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 3a:

 * signifies the current active mode



