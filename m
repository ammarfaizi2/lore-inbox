Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbWGHC4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWGHC4w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 22:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbWGHC4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 22:56:52 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:45335 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932490AbWGHC4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 22:56:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=inwJXYaPlJpq78bXYKSjug1CNl7/h67F3erdNQe82wO9q8upHnDGiWsLHarcS20KvANH3lduRF+V4hrKwG5KG3hvdaDTw0I6YTpuiTixGekqFM8bQzzzK2aXzCLnwupnEYBftS1GSCRLhEIm1Y+V0UzHt1zX9S+DILP2U/xzbpw=
Message-ID: <9e4733910607071956q284a2173rfcdb2cfe4efb62b4@mail.gmail.com>
Date: Fri, 7 Jul 2006 22:56:51 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Opinions on removing /proc/tty?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone use the info in /proc/tty? The hard coded device names
aren't compatible with udev's ability to rename things.

There also doesn't appear to be any useful info in the drivers portion
that isn't already available in sysfs. I can add some code to make a
list of registered line disciplines appear in sysfs.

Does anyone have a problem with deleting /proc/tty if ldisc enum
support is added to sysfs?

[root@jonsmirl tty]# cat drivers
/dev/tty             /dev/tty        5       0 system:/dev/tty
/dev/console         /dev/console    5       1 system:console
/dev/ptmx            /dev/ptmx       5       2 system
/dev/vc/0            /dev/vc/0       4       0 system:vtmaster
serial               /dev/ttyS       4 64-67 serial
pty_slave            /dev/pts      136 0-1048575 pty:slave
pty_master           /dev/ptm      128 0-1048575 pty:master
unknown              /dev/tty        4 1-63 console
[root@jonsmirl tty]#

[root@jonsmirl tty]# cat ldiscs
n_tty       0

-- 
Jon Smirl
jonsmirl@gmail.com
