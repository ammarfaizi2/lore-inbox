Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWAZAhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWAZAhU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 19:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWAZAhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 19:37:19 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:57870 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751276AbWAZAhR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 19:37:17 -0500
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Jens Axboe <axboe@suse.de>, grundig@teleline.es,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       jengelh@linux01.gwdg.de, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
	<Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
	<20060125144543.GY4212@suse.de>
	<Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
	<20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
	<20060125181847.b8ca4ceb.grundig@teleline.es>
	<20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de>
From: Nix <nix@esperi.org.uk>
X-Emacs: (setq software-quality (/ 1 number-of-authors))
Date: Thu, 26 Jan 2006 00:36:39 +0000
In-Reply-To: <43D7C1DF.1070606@gmx.de> (Matthias Andree's message of "25 Jan
 2006 18:23:16 -0000")
Message-ID: <878xt3rfjc.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jan 2006, Matthias Andree prattled cheerily:
> Jens Axboe wrote:
> 
>> In fact it would be a _lot_ easier to just scan sysfs and do an inquiry
>> on potentially useful devices.
> 
> Hm. sysfs, procfs, udev, hotplug, netlink (for IPv6) - this all looks rather
> complicated and non-portable. I understand that applications that can just
> open every device and send SCSI INQUIRY might want to do that on Linux, too.

Applications (already) do this by asking HAL, which can be informed of
new devices in a variety of ways: the up-and-coming one is for the
kernel to notify udevd, following which a udev rule sends a dbus message
to HAL. Everything from the dbus message on up is cross-OS portable.
-scanbus is *totally* unnecessary.

(Furthermore, it fails to work in a quite laughable fashion in the
presence of hotpluggable storage media. udev handles giving hotpluggable
storage media consistent device names with extreme ease, and tells HAL
about them so that users see the new devices appear even if they don't
have a clue that /dev even exists.

The change that J. Random Nontechnical User will ever run `cdrecord
-scanbus' is *nil*, and applications don't run it either because they
can't judge between all the devices that are listed to pick the one
which is a CD recorder (consider the consequences should they guess
wrong!). Instead, they invariably ask for a device name, or, in more
recent versions get the info from HAL. HAL knows if something is a CD
recorder because its backend, e.g. udev, told it.)

-- 
`Everyone has skeletons in the closet.  The US has the skeletons
 driving living folks into the closet.' --- Rebecca Ore
