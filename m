Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWBLQEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWBLQEY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 11:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWBLQEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 11:04:24 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:45269 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750804AbWBLQEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 11:04:23 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
To: Joerg Schilling <schilling@fokus.fraunhofer.de>, matthias.andree@gmx.de,
       peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Reply-To: 7eggert@gmx.de
Date: Sun, 12 Feb 2006 17:03:55 +0100
References: <5E0mO-7c4-25@gated-at.bofh.it> <5E0wj-7nC-1@gated-at.bofh.it> <5E0Q5-7Nq-37@gated-at.bofh.it> <5EgBc-5nU-9@gated-at.bofh.it> <5En0E-6QU-27@gated-at.bofh.it> <5En9R-73g-13@gated-at.bofh.it> <5EnCS-7Qt-35@gated-at.bofh.it> <5EnW8-8go-3@gated-at.bofh.it> <5EnWo-8go-31@gated-at.bofh.it> <5EEkg-7AS-41@gated-at.bofh.it> <5EEX1-8py-41@gated-at.bofh.it> <5EFJk-1bU-31@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1F8Jhc-00012x-Cd@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> Matthias Andree <matthias.andree@gmx.de> wrote:

>> > > Nonsense. The b,t,l addresses are NOT stable (at least for transports
>> > 
>> > Dou you like to verify that you have no clue on SCSI?
>>
>> How does, for instance, libscg make sure that the b,t,l mappings are
>> hotplug invariant?
>>
>> How does libscg make sure that two external writers, say USB, retain
>> their b,t,l mappings if both are unplugged and then replugged in reverse
>> order, perhaps into different USB hubs?
> 
> Well, this is a deficit of the Linux kernel - not libscg.
> 
> If you are unhappy with Hot plug support on Linux, I recommend you to
> check Solaris.

I see only support for 16*16*8=2048 devices in scsi-sun.c. Therefore you need
at most 2049 devices to have no possibility for stable device<->b,t,l
relation. Asume 2048 devices had been plugged into USB, so that you have the
mapping 0,0,0 -> yellow burner .. 15,15,7 -> purple burner. If you reuse any
of these IDs, also plugging in the corresponding device would result in a
non-stable ID. (One broken device with serial number = `dd if=/dev/random`
will do the trick, too.)

So if you can't create a stable mapping using b,t,l, why should you bother
trying and mislead your users into asuming a stable mapping? And why should
you impose a btl mapping if it's possible to allow naming the device whatever
the user likes, causing the number of stable device names to be limited only
by it's lifetime?

The only things you need is a list of devices and a way to map a unique ID
to a device name. I posted scripts that will so that.

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
