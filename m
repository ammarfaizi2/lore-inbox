Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUCCKCu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 05:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbUCCKCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 05:02:50 -0500
Received: from dinsnail.net ([217.160.166.159]:33946 "EHLO heinz.dinsnail.net")
	by vger.kernel.org with ESMTP id S262370AbUCCKCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 05:02:48 -0500
Date: Wed, 3 Mar 2004 10:56:15 +0100
From: Michael Weiser <michael@weiser.dinsnail.net>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
Message-ID: <20040303095615.GA89995@weiser.dinsnail.net>
References: <20040303000957.GA11755@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303000957.GA11755@kroah.com>
User-Agent: Mutt/1.4.2.1i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 04:09:57PM -0800, Greg KH wrote:
> Major changes from the 019 version:
> 	- new variable $local for the udev.permission file allows
> 	  permissions to be set for the currently logged in user.
Yay, just the other day I thought that might be a nice feature in
concert with RedHat's/Fedora's pam_console module. Am I right in
assuming that the current utmp based code will give the file to the user
that most recently logged into the local console? This could cause some
confusion with the pam_console-method which gives files to the user that
logged in *first* on a local console.

Call me stupid but I have two other questions that look quite simple but
I can't seem to wrap my head about:

Normally with static /dev one has a /dev/dsp device for example. As soon
as an application tries to open it the kernel would try to load a module
"sound" or "char-major-something" if sound support isn't compiled into
it. Now with udev I'll never get /dev/dsp in the first place and there's
no mechanism like devfs's file open monitoring and subsequent device
file creation. So my idea is to initialise /dev with some static files,
for hardware I know is there but hasn't had a driver loaded yet. My
question is: Is there a nicer and more elegant way than just unpacking a
tarball into /dev before starting udevd? A tarball would also break a
(theoretical) use of dynamic major/minor numbers by the kernel.

Also I very much liked the automatic creation of /dev/root by devfs
because it kept the system bootable after moves around different
harddrives and partitions several times where I would normally have
forgotten to adjust fstab to the new root. I poked around sysfs and proc
a bit but can't seem to find anything that would permit me to simlute
that behaviour with udev. Does udev perhaps already support something
like this?

Thanks in advance for any advice.
-- 
bye, Micha
