Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWEJVYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWEJVYF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 17:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWEJVYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 17:24:05 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:64699 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S964865AbWEJVYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 17:24:04 -0400
Message-ID: <446259F2.4080308@free.fr>
Date: Wed, 10 May 2006 23:24:02 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata PATA patch update
References: <1147104400.3172.7.camel@localhost.localdomain>	 <pan.2006.05.08.21.57.53.522263@free.fr> <1147178241.3172.74.camel@localhost.localdomain> <4460D7D7.3070807@free.fr>
In-Reply-To: <4460D7D7.3070807@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
matthieu castet wrote:
> Hi,
> 
> Alan Cox wrote:
> 
>> On Llu, 2006-05-08 at 23:57 +0200, Matthieu CASTET wrote:
>>
> 
>>
>>> PS : any idea in order to allow to work my cdrw drive, that don't return
>>> interrupt when setting xfermode ?
>>
>>
>>
>> The real question is "why is it not returning an interrupt", as it is
>> required to do so unless nIEN masking is active. Handling that is a
>> matter for the libata core itself and depends on what Jeff has planned,
>> but I'm still a bit bothered that it may not be a drive problem but a
>> bug in the via pata driver.
> 
> You seem right : I tried the drive on the sil680 and it works [1].
> The same config (only one slave drive channel 1) fails [2].
> What is strange it that there is the same problem with the old via ide 
> driver and hdparm -X [3].
> Have you any hint what could I try ?
> 

It seems there is really a bug in the timing code.
I attach the lspci diff (from ide to pata) and the viaideinfo one


Matthieu

  00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
  10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  20: 01 fc 00 00 00 00 00 00 00 00 00 00 06 11 71 05
  30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 00 00
  40: 0b f2 09 35 18 1c c0 00 20 20 20 20 ff 00 20 20
-50: e6 e6 e1 e1 0c 00 00 00 a8 a8 a8 a8 00 00 00 00
+50: 27 27 27 27 0c 00 00 00 a8 a8 a8 a8 00 00 00 00
  60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
  70: 02 01 00 00 00 00 00 00 02 01 00 00 00 00 00 00
-80: 00 40 ed 3f 00 00 00 00 00 00 00 00 00 00 00 00
+80: 00 f0 b9 01 00 00 00 00 00 50 a9 01 00 00 00 00
  90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


@@ -16,7 +16,7 @@
  Post Write Buffer:            yes                 yes
  Enabled:                      yes                 yes
  Simplex only:                  no                  no
-Cable Type:                   80w                 40w
+Cable Type:                   40w                 40w
  -------------------drive0----drive1----drive2----drive3-----
  Transfer Mode:       UDMA      UDMA      UDMA      UDMA
  Address Setup:      120ns     120ns     120ns     120ns
@@ -24,5 +24,5 @@
  Cmd Recovery:        30ns      30ns      30ns      30ns
  Data Active:         90ns      90ns      90ns      90ns
  Data Recovery:       30ns      30ns      30ns      30ns
-Cycle Time:          22ns      22ns      60ns      60ns
-Transfer Rate:   88.8MB/s  88.8MB/s  33.3MB/s  33.3MB/s
+Cycle Time:          67ns      67ns      67ns      67ns
+Transfer Rate:   29.6MB/s  29.6MB/s  29.6MB/s  29.6MB/s
