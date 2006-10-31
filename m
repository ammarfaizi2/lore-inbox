Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423535AbWJaQJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423535AbWJaQJk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423541AbWJaQJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:09:40 -0500
Received: from maximus.itgardendrift.se ([193.138.74.3]:2634 "EHLO
	DR2EX01.hosting.itg") by vger.kernel.org with ESMTP
	id S1423535AbWJaQJj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:09:39 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: RE: RE: PROBLEM: raid5 just dies
Date: Tue, 31 Oct 2006 17:09:54 +0100
Message-ID: <6FDE26082D451C41BE1A3742966200B3BAED1F@DR2EX01.hosting.itg>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RE: RE: RE: PROBLEM: raid5 just dies
Thread-Index: Acb8dV0jc59rSL74QNCft+NBPu0E4wAkQk6g
From: "Andreas Paulsson" <andreas.paulsson@itgarden.se>
To: "Neil Brown" <neilb@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Monday October 30, andreas.paulsson@itgarden.se wrote:
>> >Exactly how are aes-loop and raid5 connected together?
>> 
>> We use 5x300gb drives in a raid5 array, which is then used as a 
>> physical disk in an lvm volume, with one logical volume. This logical

>> volume is then encrypted with "losetup -e aes /dev/loop1 
>> /dev/vg0/lv0", and then formatted with ReiserFS.

>Thanks.
>
>It could be a hardware problem....
>The symptom is that we try to free some memory and a
>consistency check tells us that the memory wasn't allocated.
>So a single bit error in the address could be thecause.
>Running memtest86 for a while wouldn't hurt if you haven't
>already done that.

I'll see if I get get someone to do a memtest for me (the box is 600km
away).

>You have three layers here: loop over dm over md/raid5.
>So if it is a software problem it could be in any of these layers,
>or in an interaction between two of them.

>1/ how repeatable is this?

cp -arv source target
.. and then wait for a while, and it crashes. That is, 100% repeatable.

>2/ how much room have you got to experiment?
> Could you remake the array without the loop/aes and see if you can
>reproduce the problem?

I could, but then I would need to redo all the work again, since we need
the disk to be encrypted too.

>Could you remake the array without the LVM layer and see if you can
>reproduce the problem?

No, this is impossible, we need to have LVM because we are making one
big volume that consists of raid5 and raid1 devices.

>Do you have CONFIG_DEBUG_PAGEALLOC and CONFIG_DEBUG_SLAB set?
>If not could you >recompile with those set to see if they
>provide more helpful information.

I can try and see if it helps.

>I must admit I am somewhat at a loss.
>I cannot see much room for problems leading to that
>particular point in the code that would not be seen
>by lots more people than just you.

Heh, you're not the only one that's lost.

>NeilBrown

/Andreas
