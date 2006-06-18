Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWFRNfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWFRNfv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 09:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWFRNfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 09:35:51 -0400
Received: from web26512.mail.ukl.yahoo.com ([217.146.177.59]:4982 "HELO
	web26512.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932232AbWFRNfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 09:35:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=lQaf27zJMRJO4nn36X6HKuHlEcsq+pRYgj+wbH83BIT6cl4/sq9gx9M34kpF45ht3JzSwXJ3j70r4BKly6ewAxSGf9f75Iiaba13jAoz72aP60CmMHtZCnGmvFv18uUkXsyrBYrrzpwMB8T4X0esENeclxVRmg43BnJyd7gGlsE=  ;
Message-ID: <20060618133549.24302.qmail@web26512.mail.ukl.yahoo.com>
Date: Sun, 18 Jun 2006 15:35:49 +0200 (CEST)
From: karsten wiese <annabellesgarden@yahoo.de>
Subject: Re: sound skips on 2.6.16.17
To: Hugo Vanwoerkom <rociobarroso@att.net.mx>, Chris Wedgwood <cw@f00f.org>
Cc: ck@vds.kolivas.org, linux list <linux-kernel@vger.kernel.org>
In-Reply-To: <449534DA.8040103@att.net.mx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Hugo Vanwoerkom <rociobarroso@att.net.mx> schrieb:

> Chris Wedgwood wrote:
> > On Sun, Jun 18, 2006 at 12:04:29PM +0800, ocilent1 wrote:
> >
> >   
> >> (PCI-quirk-VIA-IRQ-fixup-should-only-run-for-VIA-southbridges.patch)
> >> that is causing the sound stuttering/skipping problems for our users
> >> with VIA chipsets. Backing out the first patch alone did not fix the
> >> problem (PCI-VIA-quirk-fixup-additional-PCI-IDs.patch) but to back
> >> out the 2nd patch, you need to have initially backed out the first
> >> patch, due to the way the patches apply in series.
> >>     
> >
> > what mainboard/CPU do you have there?
> >
> > what does 'lspci -n' say?
> >
> >   
> 
> /home/hugoSun Jun 18-06:08:30HDC1# lspci -n
> 0000:00:00.0 0600: 1106:0269
> 0000:00:00.1 0600: 1106:1269
> 0000:00:00.2 0600: 1106:2269
> 0000:00:00.3 0600: 1106:3269
> 0000:00:00.4 0600: 1106:4269
> 0000:00:00.7 0600: 1106:7269
> 0000:00:01.0 0604: 1106:b198
> 0000:00:0a.0 0300: 10de:0181 (rev a2)
> 0000:00:0b.0 0104: 1095:3112 (rev 02)
> 0000:00:0c.0 0401: 1102:0007
> 0000:00:0f.0 0101: 1106:0571 (rev 06)
> 0000:00:10.0 0c03: 1106:3038 (rev 81)
> 0000:00:10.1 0c03: 1106:3038 (rev 81)
> 0000:00:10.2 0c03: 1106:3038 (rev 81)
> 0000:00:10.3 0c03: 1106:3038 (rev 81)
> 0000:00:10.4 0c03: 1106:3104 (rev 86)
> 0000:00:11.0 0601: 1106:3227
> 0000:00:11.5 0401: 1106:3059 (rev 60)
> 0000:00:12.0 0200: 1106:3065 (rev 78)
> 0000:01:00.0 0300: 10de:0185 (rev c1)
> 

had sound skipping here too with likely the same southbridge:
(AMD64 K8T800 mobo)
# lspci -n
00:00.0 0600: 1106:0282
00:00.1 0600: 1106:1282
00:00.2 0600: 1106:2282
00:00.3 0600: 1106:3282
00:00.4 0600: 1106:4282
00:00.7 0600: 1106:7282
00:01.0 0604: 1106:b188
00:0b.0 0200: 10ec:8169 (rev 10)
00:0f.0 0101: 1106:0571 (rev 06)
00:10.0 0c03: 1106:3038 (rev 81)
00:10.1 0c03: 1106:3038 (rev 81)
00:10.2 0c03: 1106:3038 (rev 81)
00:10.3 0c03: 1106:3038 (rev 81)
00:10.4 0c03: 1106:3104 (rev 86)
00:11.0 0601: 1106:3227
00:11.5 0401: 1106:3059 (rev 60)
00:18.0 0600: 1022:1100
00:18.1 0600: 1022:1101
00:18.2 0600: 1022:1102
00:18.3 0600: 1022:1103
01:00.0 0300: 10de:0185 (rev c1)

backing out above patches didn't help.
Enabling variable samplerate support by loading
snd-via82xx like this:
# rmmod snd-via82xx
# modprobe snd-via82xx dxs_support=5
made the difference here.

Also I completely disabled PCI-quirk-VIA-IRQ-fixup here without
any negative impact.
When active, it reports nonsense here:
"PCI: VIA IRQ fixup for 0000:00:0f.0, from 255 to 0"
"PCI: VIA IRQ fixup for 0000:00:10.0, from 11 to 3"


      Karsten


		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de
