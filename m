Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbTI1QaN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 12:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbTI1QaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 12:30:13 -0400
Received: from quechua.inka.de ([193.197.184.2]:12743 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262605AbTI1QaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 12:30:06 -0400
Subject: Re: Linux 2.6.0-test6
From: Andreas Jellinghaus <aj@dungeon.inka.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030928123432.GA23693@redhat.com>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org>
	 <pan.2003.09.28.11.05.34.596021@dungeon.inka.de>
	 <20030928123432.GA23693@redhat.com>
Content-Type: text/plain
Message-Id: <1064765545.741.69.camel@simulacron>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 28 Sep 2003 18:12:26 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So, 2003-09-28 at 14:34, Dave Jones wrote:
> On Sun, Sep 28, 2003 at 01:05:35PM +0200, Andreas Jellinghaus wrote:
>  > test6 (plus hostap patch) hangs during boot.
>  > The last line I see is 
>  > cpufreq: Intel(R) SpeedStep(TM) for this chip set not (yet) available.
> 
> Does it still hang if you disable the speedstep driver ?

# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
now it works fine.

> What happens if you don't pass the hda geometry ?
> And, why do you need to ?

the dell bios detects the disc as */16/63. However the
partition table is created with */255/63 in mind.
most bios allow to set the geometry manually or change
the large/lba/normal mode. the dell bios does not.

Linux boots fine without the hda= setting, as it only
uses start and length values. But other tools might have
problems (grub? *fdisk?).

Also I used to use drive image / dos version with network stack
for duplicating discs. and drive image only worked with win
and linux partitions, if the emulation geometry was */255/63.
Not sure why. But because of that all blank discs are created
with */255/63 tables. all other machines I know can be configured
via that large/lba/normale mode setting, or simply read the partition
table and automatically adjust to the geometry found.

Ah, live would be so much easier without chs geometries.

Is there any tool that will change chs begin/end values
from */255/63 geometry to */16/63 geometry? 

/dev/discs/disc0/part1 : start=       63, size=   112392, Id=83, b
/dev/discs/disc0/part2 : start=  2216970, size= 36853110, Id=83
/dev/discs/disc0/part3 : start=   112455, size=  2104515, Id=82

x/16/63 world:
0/1/1 - 111/8/63, 111/9/1 - 2199/5/63, 2199/6/1 - 38759/15/63

y/255/63 world:
0/1/1 - 6/254/63, 7/0/0 - 137/254/63, 138/0/1 - 2431/254/63

maybe there is still some software out there, that will not like
partitions beginning on something different then */0/1 or
*/1/1. I rather not change the partition table to */16/63
fake geometry.

I could backup everything, null the partition table, create a
new one with */16/63 chs geometry and restore all data. 
but for now using hda= to set the fake geometry works fine.

Regards, Andreas

