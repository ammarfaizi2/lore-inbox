Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136001AbRD0JpH>; Fri, 27 Apr 2001 05:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135998AbRD0Jo6>; Fri, 27 Apr 2001 05:44:58 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:58372 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S135940AbRD0Jon>; Fri, 27 Apr 2001 05:44:43 -0400
To: AJ Lewis <lewis@sistina.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: devfs and /proc/ide/hda
In-Reply-To: <3A9CCA76.3E6AB93A@optushome.com.au>
	<20010228161023.A19929@win.tue.nl> <20010301084133.C16667@sistina.com>
From: Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>
Date: 08 Mar 2001 13:32:03 +0100
In-Reply-To: AJ Lewis's message of "Thu, 1 Mar 2001 08:41:33 -0600"
Message-ID: <87snkov3uk.fsf@mose.informatik.uni-tuebingen.de>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Crater Lake)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == AJ Lewis <lewis@sistina.com> writes:

     > On Wed, Feb 28, 2001 at 04:10:23PM +0100, Guest section DW
     > wrote:
    >> On Wed, Feb 28, 2001 at 08:52:54PM +1100, Glenn McGrath wrote:
    >> 
    >> > Im running kernel 2.4.1, I have entries like /proc/ide/hda, >
    >> /proc/ide/ide0/hda etc irrespective of wether im using devfs or
    >> > traditional device names.  > > Is always using traditional
    >> device names for /proc/ide intentional, or > is it something
    >> nobody has gotten around to fixing yet?
    >> 
    >> If only humans look at /proc, and they like typing long names,
    >> then there is no objection against changing /proc.  As it is,
    >> however, quite a few programs look at /proc for information
    >> about devices. I don't think it would be a good idea to "fix"
    >> /proc and simultaneously break all these programs.

     > What it should do is change based on whether devfs is mounted
     > or not.  It doesn't make *any* sense to have
     > /dev/ide/host0/foo/bar in your /proc/partitions entries if you
     > aren't mounting devfs.  The /proc/partitions entry is the only
     > way I know of for something like LVM to determine which devices
     > to scan for Volume Groups.  If you can't read /proc/partitions,
     > it has to attempt to scan all block devices it recognizes,
     > regardless of whether they are actually on the system or not.
     > This can take several minutes.

First:

% cat /proc/partitions 
major minor  #blocks  name

   3     0   20010816 ide/host0/bus0/target0/lun0/disc
   3     1     192748 ide/host0/bus0/target0/lun0/part1
   3     2     249007 ide/host0/bus0/target0/lun0/part2
   3     3          1 ide/host0/bus0/target0/lun0/part3
   3     5     289138 ide/host0/bus0/target0/lun0/part5
   3     6    1951866 ide/host0/bus0/target0/lun0/part6
   3     7     979933 ide/host0/bus0/target0/lun0/part7
   3     8   16346106 ide/host0/bus0/target0/lun0/part8
  33     0   80043264 ide/host2/bus0/target0/lun0/disc
  33     1   80035798 ide/host2/bus0/target0/lun0/part1

So its already right.

Secondly with devfs, why not just scan all /dev/discs/?

% ls -l /dev/discs 
total 0
lr-xr-xr-x    1 root     root           30 Jan  1  1970 disc0 -> ../ide/host0/bus0/target0/lun0/
lr-xr-xr-x    1 root     root           30 Jan  1  1970 disc1 -> ../ide/host2/bus0/target0/lun0/

Also if lvm opens all known devices by way of /dev/whatever while
scanning, it will only find existing devices there with devfs.

MfG
        Goswin
