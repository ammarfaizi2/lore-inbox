Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWG3Jwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWG3Jwz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 05:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWG3Jwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 05:52:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:15312 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932179AbWG3Jwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 05:52:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ieyEcXZxc7KJWV/AoNMlgOFmgg3O02+KNtTI5p+2GBBX7NXZCML6Bbw+66R1/v+15iFVSAui43yZWHtvrljJB4IafcotSOBQYue+xsxrzzeK2Gl+4nPqT5E512xmR8OJ+OivbE/d/qwFBquS8wE9hfXOR/GLICqNKq+O2j4MxVk=
Message-ID: <41840b750607300252w445974b1udedf1a67114d1580@mail.gmail.com>
Date: Sun, 30 Jul 2006 12:52:52 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: Generic battery interface
Cc: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       "Vojtech Pavlik" <vojtech@suse.cz>, "Brown, Len" <len.brown@intel.com>,
       "Pavel Machek" <pavel@suse.cz>, "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
In-Reply-To: <20060730085500.GB17759@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz>
	 <d120d5000607280525x447e6821t734a735197481c18@mail.gmail.com>
	 <41840b750607280819t71f55ea7off89aa917421cc33@mail.gmail.com>
	 <d120d5000607280910t458fb6e0hdb81367b888a46db@mail.gmail.com>
	 <20060730085500.GB17759@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/06, Greg KH <greg@kroah.com> wrote:
> > >Forgive my ignorance, but how do I conncet a sysfs directory with a /dev
> > >device?

> Just look at the "dev" file in sysfs, which shows the major:minor
> number.

Then to find the match for a given device node you need to enumerate /sys.
And to find a match for a given /sys device you need to enumerate
/dev, or some its subdirectories (/dev/{snd,input,...), or whatever
other random places people have decided to place their device nodes.


> Or just look at the directory that you are in, and that's almost always
> the /dev node name.
>
> For example, /sys/block/sda/sda1/ is /dev/sda1.
> /sys/class/tty/ttyS1 is /dev/ttyS1.

Yeah, and /sys/block/sr0 is /dev/scd0 (FC5 default udev rules).


> It's usually not that difficult to do the mapping :)

Hmm, "usually"...


Coming to think of it, to solve the dev->sys direction, maybe we
should have symlinks like the following?
/sys/dev/8/0 -> /sys/block/sda
/sys/dev/11/0 -> /sys/block/sr0
/sys/dev/116/24 -> /sys/class/sound/pcmC0D0c


Put otherwise:
Q:Quick, which io scheduler is used by /dev/scd0?
A: cat /sys/dev/$((0x`stat -c%t /dev/scd0`))/\
                $((0x`stat -c%T /dev/scd0`))/queue/scheduler

(Please excuse the ugly hex to dec conversion.)


  Shem
