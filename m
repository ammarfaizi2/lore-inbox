Return-Path: <linux-kernel-owner+w=401wt.eu-S1030314AbXAEEdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbXAEEdP (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 23:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbXAEEdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 23:33:15 -0500
Received: from sccmmhc91.asp.att.net ([204.127.203.211]:36299 "EHLO
	sccmmhc91.asp.att.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030313AbXAEEdO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 23:33:14 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 23:33:14 EST
From: Steve Brueggeman <xioborg@mchsi.com>
To: Auke Kok <sofar@foo-projects.org>
Cc: Akula2 <akula2.shark@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Multi kernel tree support on the same distro?
Date: Thu, 04 Jan 2007 22:28:12 -0600
Message-ID: <tekrp2tqo78uh6g2pjmrhe0vpup8aalpmg@4ax.com>
References: <8355959a0701041146v40da5d86q55aaa8e5f72ef3c6@mail.gmail.com> <459D9872.8090603@foo-projects.org>
In-Reply-To: <459D9872.8090603@foo-projects.org>
X-Mailer: Forte Agent 4.1/32.1088
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are some difficulties with gcc versions between linux-2.4 and linux-2.6,
but I do not recall all of the details off of the top of my head.  If I recall
correctly, one of the issues is, linux-2.4 ?prefers? gcc-2.96, while newer
linux-2.6 support/prefer gcc-3.? or greater.

At any rate, what I've done is create a chroot environment.  I created this
chroot directory by installing an older distribution that was created with
linux-2.4 in mind (example, RedHat v8.2) into that at chroot directory.  The
easiest way to do this that I'm aware of is to install the older distribution
(minimal development, no server junk, no X junk) on another computer, then copy
from that computer to a directory on your development computer.

Then chroot to that directory with something like

chroot /home/linux-2.4-devel /bin/bash
mount /proc

Note that I have had some issues with having a linux-2.6 kernel on /proc with a
linux-2.4 distribution, but nothing that greatly affects code development.

Of course, I'm assuming that you are the only person that has access to this
development computer, because chroot is a security risk (example: cd /; cd ..)

Sorry for being short on details, but I hope this helps.

Steve Brueggeman


On Thu, 04 Jan 2007 16:14:42 -0800, you wrote:

>Akula2 wrote:
>> Hello All,
>> 
>> I am looking to use multiple kernel trees on the same distro. Example:-
>> 
>> 2.6.19.1 for - software/tools development
>> 2.4.34    for - embedded systems development.
>> 
>> I do know that 2.6 supports embedded in a big way....but still
>> requirement demands to work with such boards as an example:-
>> 
>> http://www.embeddedarm.com/linux/ARM.htm
>> 
>> My question is HOW-TO enable a distro with multi kernel trees?
>> Presently am using Fedora Core 5/6 for much of the development
>> activities (Cell BE SDK related at Labs).
>> 
>> Any hints/suggestions would be a great leap for me to do this on my own.
>
>this is really no big problem (as in: works OOTB), except that if you want to boot & run 
>both kernels on the same (rootfs) installation, you will need to create wrappers around 
>modutils and module-init-tools, as well as udev/devfs, or whichever device file system 
>you prefer to use for each kernel. There are a few minor other details but none really 
>shocking.
>
>We've done this for "our" source distro, and it works just fine.
>
>Cheers,
>
>Auke
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
