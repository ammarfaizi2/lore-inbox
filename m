Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWEZQBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWEZQBU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWEZQBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:01:20 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:44635 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750899AbWEZQBT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:01:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=r1+7pjl6+Co5WiWXJxzeaYzOSFWEupQhHoc/j1B7YbCQ5A1p1iOimBjcVyELNA3CpDRpLdTIKcXjCTfQbhnmxEH4GMMIqeMDG/7pTajtZHJ5ZugN42tjmMup/kTt8bN6w2RaWZJS2Ce6KDgBi9fxb1T48RlqmbBtnWdQKLf+HYQ=
Message-ID: <9e4733910605260901h6452c795s1c40cf61b47fc69a@mail.gmail.com>
Date: Fri, 26 May 2006 12:01:15 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Kernel design: support for multiple local users
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A central, unanswered question in the graphics debate is whether the
kernel should directly support multiple users logged into video cards.
Currently this is not supported. A simple example of this is a two
headed video card and two keyboards. Should the kernel support two
independent users logged into these heads and give them the ability to
control their environment without needing to be root?

This situation commonly occurs in Internet cafes, kiosks, schools,
etc. There are several out of tree patches addressing this. I also
believe there are multiple vendors selling products in this
configuration.

It is possible to set the current X server up to support this
configuration. Using the X server this way has some drawbacks. The X
server needs to be run as root. The multiple users are sharing a
single X server image so things they do can impact the other users.
Plus this solution only works for X apps. Things like VT swap must be
disabled.

An alternative model with kernel support would work something like
this. Devices are created for each video head. Devices (video, mouse,
keyboard, usb ports, cdrom, etc) are marked as belonging in a console
grouping. When you log in ownership of the grouped devices is assigned
to you.

Now that you have ownership of the devices you are able to control
them without being root. If you want to change your video mode ask
your video device to do it (this is not a comment on how the video
device achieves the mode change). Since the devices are locally owned
each user can independently run X, emacs, svglib or whatever.

I am obviously leaving out some details about how sharing the
resources of a single video card between heads is achieved. If you
prefer, think of this scenario for two installed graphics cards. This
is not an attempt to detail how to build the feature.

The question is, do we want local multiuser support in the kernel, or
should it be an application feature?

-- 
Jon Smirl
jonsmirl@gmail.com
