Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbUAAQ5l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 11:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264502AbUAAQ5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 11:57:40 -0500
Received: from colossus.systems.pipex.net ([62.241.160.73]:62416 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id S264501AbUAAQ5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 11:57:39 -0500
From: Shaheed <srhaque@iee.org>
To: linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Date: Thu, 1 Jan 2004 16:59:35 +0000
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401011659.35973.srhaque@iee.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

>Combine that with hotplug and you have a world of pain. Generating a number 
> from a device is just a fancy hashing function, but as soon as you have two 
> devices that generate the same number independently (when in separate 
> systems) and you plug them both into the same system: boom.

If one has two otherwise identical devices, the only thing that distinguishes 
them to the system is their point of attachment. Even from a user's point of 
view, the only difference is the connector it is plugged into. That implies 
that the hash resolution value ought to be based on the point of attachment.

It seems to me that the key to making this system as transparent as possible 
is to make these source value of the hash and the attachment point visible 
and navigable by userspace/humans. Perhaps something like this:

- every driver exports its name and some driver-or-devicetype-dependant value 
(serial number, MAC address, disk WWID, pty number, kernel address of kobject 
or whatever) to /sbin/hotplug. The userspace logic gets to hash+uniquify the 
value as required, and then create a sysfs tree node ("/uid/xxx") whose 
leaves contain the point of attachment.

- At the bottom of the sysfs tree for the device add a leaf that points back 
to the entry into "/uid" tree.

Thus, userspace can navigate in either direction between the point of 
attachment, and the identifiying characteristic of the deivce.

Thanks, Shaheed
