Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWACXLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWACXLO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWACXKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:10:30 -0500
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:29709 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S964841AbWACXKT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:10:19 -0500
Date: Wed, 4 Jan 2006 00:10:13 +0100 (CET)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Adrian Bunk <bunk@stusta.de>
cc: Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Tomasz Torcz <zdzichu@irc.pl>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Andi Kleen <ak@suse.de>, perex@suse.cz, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
In-Reply-To: <20060103193736.GG3831@stusta.de>
Message-ID: <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
References: <20050726150837.GT3160@stusta.de> <200601031629.21765.s0348365@sms.ed.ac.uk>
 <20060103170316.GA12249@dspnet.fr.eu.org> <200601031716.13409.s0348365@sms.ed.ac.uk>
 <20060103192449.GA26030@dspnet.fr.eu.org> <20060103193736.GG3831@stusta.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-212284991-1136329813=:29027"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-212284991-1136329813=:29027
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 3 Jan 2006, Adrian Bunk wrote:

> On Tue, Jan 03, 2006 at 08:24:49PM +0100, Olivier Galibert wrote:
>> On Tue, Jan 03, 2006 at 05:16:13PM +0000, Alistair John Strachan wrote:
>>> This argument is basically watered down with devfs, udev, sysfs, etc. which
>>> all have exactly the same issues. Should a crippled OSS API be the way
>>> forward for Linux? I think not.
>>
>> And they're getting some real backlash because of that now.  Hell,
>> Linus' message was about udev in the first place.
>
> The udev breakages might not have been nice, but OSS/ALSA is a
> completely different issue:
>
> OSS has been deprecated since ALSA was merged into the Linux kernel
> _four years ago_.

Also more than four years exist another thing: generaly sound suport in 
Linux kernel is broken by design. Points where it is broken:

1) ALSA API forces not use devices files and many things on sound managing
   level are handled on user space library. This dissallow civilized
   redirection sound stream in runed application without this application
   interractions (try redirect sound stream on runed application for
   example to headset .. simple case skype .. oh you probaly don't know: in
   current ALSA infrastructure there is no civilized way for handle
   gadgests like BT headsets). In current ALSA API (IIRC) you must write in
   special way applications for handle this (look pint 2)).

2) ALSA API is to complicated: most applications opens single sound
   stream.
   All what system user expect it is plaing sound by more then one
   application with simple mixing sound streams. For me ALSA is prepared
   like for handle ANY sound case .. EXCEPT all most simpler.

3) ALSA kernel architecture is to complicated. This main reason why
   configuring sound on Linux is SO COMPLICATED. From my system:

# lsmod | grep ^snd | wc -l
19

   All this for handle ONLY ONE sound card. Why not one alsa main module
   and one with hardware backend module like in comarcial OSS ?

   ALSA is also requires much more bigger code size than OSS variant
   (count all snd* modules size, jackd and libasound and compare this with
   OSS modules and user space OSS library size). Simillar is on allocated
   memory in all system sound components.
   Many task switches incurred by the current ALSA architecture
   add quickly up to perceivalble deleys during processing. In many cases
   sound must be handled with RT piorites so all code sise must possible
   small for handle this with minimal latency.

4) ALSA mixing model is UNSECURE by design because all mixing sound
   streams (for example with diffrent sampling rates) are performed
   in user space.
   Also using jackd also "creates problems" with RTing this proccess and
   much more bigger problems on configure stage (for joe user).
   All this can be handled in secure and proprer RT prioprities
   ONLY on kernel space (so all gaming mith jackd or so is plain waste
   of time). Only on kernel level is possible correctly handle all this.
   With ALSA you can't extend in esy way for example SELinux for prevent
   intercept sound streem from microphone by remote user. Current OSS API
   is much more better for SELinux.
   Why ? because all mixing on OSS is performed on kernel level.

   I can't understand why ALSA developers still do not understands this
   fundamentalt facts.

5) OSS API can be used not only on Linux. ALSA API can be used ONLY on
   Linux.
   This was, still is and (looks like allways) will be main reason
   for not spending so many time as it is required on polish sound
   interractions on Linux applications.
   Still I can't understand why introducing ALSA *must* break OSS user
   space API in so deep way.
   OSS user space API also have some weak poinst on to big complications
   because it allow implemet the same cases in to many forms (for some
   cases it provides more than two ways for handle some scenarios).
   I do not understand why on developing Linux soud support was forgoten
   "don't move .. improve" sentence :>
   OSS API paralelism looks lik was "correctly" implemnted in ALSA .. so
   ALSA do not improves sound handling for user space applications and
   additionaly introduces other own complications (ASA API documentations
   in many cases isn't clear).

Conclution: removing OSS from Linux kernel and force using ALSA in last 
four years was IMO one of the main resons why Linux still can't 
effectively fight on desktop area and in future will be/can be one of the 
most importand weak point which can drive Linux to die at all (in longer 
period).

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-212284991-1136329813=:29027--
