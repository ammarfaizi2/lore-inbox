Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWGIFbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWGIFbA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 01:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWGIFbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 01:31:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:21320 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964998AbWGIFa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 01:30:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PEQSYmycr8PiVRwaxcCTvJAldCB7ctjWQRZzuHaMOKzK0YoL8U/6Scq/GrAQ+ttzM4ZTVkS3SjiAqsQenceCxwD0rXTNb31ZxU2HskyCxzZmQkcix1id8v/iubVv/4NXNeAfJFAvSAM2e0V1wDprnkqtBJuqPq7yBxAfYi6w68Y=
Message-ID: <787b0d920607082230w676ddc62u57962f1fc08cf009@mail.gmail.com>
Date: Sun, 9 Jul 2006 01:30:58 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: rmk+lkml@arm.linux.org.uk, jonsmirl@gmail.com, alan@lxorguk.ukuu.org.uk,
       efault@gmx.de, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Opinions on removing /proc/tty?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl writes:
> On 7/8/06, Mike Galbraith <efault@gmx.de> wrote:
>> On Fri, 2006-07-07 at 22:56 -0400, Jon Smirl wrote:

>>> Does anyone use the info in /proc/tty? The hard coded device
>>> names aren't compatible with udev's ability to rename things.
>>>
>>> There also doesn't appear to be any useful info in the drivers
>>> portion that isn't already available in sysfs. I can add some code
>>> to make a list of registered line disciplines appear in sysfs.
>>>
>>> Does anyone have a problem with deleting /proc/tty if
>>> ldisc enum support is added to sysfs?
>>
>> ps uses /proc/tty/drivers, so some coordination would be needed.
>
> Greg, I just looked at the source for ps and it has a bunch
> of fixed code for turning major/minor into /dev/name.  Isn't
> that something udevinfo should be doing? But looking at the
> help for udevinfo I don't see any way to turn a major/minor
> into /dev/name. The altermative seems to be search /dev
> looking for the right device node.

By far, the best thing for procps (ps, top, etc.) would
be /proc/*/tty links. Code that, give everybody a year
to upgrade, and then... maybe.

There is no way I'm going to have the procps run a "udevinfo"
program, and I very much dislike relying on oddball libraries.
Reliability and performance matter; this isn't some GNOME/KDE
thing that can break just because 1 of 200 libraries changed.

In order, the procps code tries:

1. /proc/*/tty symlink (effectively commented out)
2. /proc/tty/drivers
3. /proc/*/fd/2 symlink
4. hard-coded guess
5. /proc/*/fd/255 symlink
6. "?"

Long ago, procps would search /dev for the mapping. This was
too slow to be done directly when ps ran, so a binary file in
/etc was used to cache the data. Keeping that file updated
was a major problem.

BTW, cruft gets ripped out some time after Debian-obsolete no
longer supports the old kernels.
