Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbUE2Dlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUE2Dlt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 23:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbUE2Dlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 23:41:49 -0400
Received: from www.michaelgregg.com ([64.71.189.252]:6605 "EHLO
	srv1.michaelgregg.com") by vger.kernel.org with ESMTP
	id S262906AbUE2Dlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 23:41:45 -0400
Date: Fri, 28 May 2004 20:41:43 -0700 (PDT)
From: michael gregg <linuxlist@michaelgregg.com>
X-X-Sender: linuxlist@mgregg
To: linux-kernel@vger.kernel.org
Subject: promise sataII150 devices
Message-ID: <Pine.LNX.4.44.0405282018350.7460-100000@mgregg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
I noticed there was a thread a while back about creating mountable devices 
with the carmel block driver.(some people not able to get access to the 
drives.)
 
the major numbers for the drives are 160, with minor numbers being 0-255, 
every drive getting 32 numbers. The drives themselves are going to be 
multiples of 32, and 0. 
drive 0, minor number 0
drive 0 - partition 0, minor number 1
drive 0 - partition 1, minor number 2
.
.
drive 1, minor number 32
drive 1 - partition 0, minor number 33
.
.
drive 7, minor number 224
drive 7 - partition 0, minor number 224
 
I wrote a short perl script to generate a shell script to create all of 
your devices with mknod. I'll copy the script in at the bottom of the 
file.
It generates output like this:
mknod /dev/carmel/2 b 160 64 # drive 2
mknod /dev/carmel/2p1 b 160 65 # drive 2 partition 1
mknod /dev/carmel/2p2 b 160 66 # drive 2 partition 2
mknod /dev/carmel/2p3 b 160 67 # drive 2 partition 3
mknod /dev/carmel/2p4 b 160 68 # drive 2 partition 4
mknod /dev/carmel/2p5 b 160 69 # drive 2 partition 5
mknod /dev/carmel/2p6 b 160 70 # drive 2 partition 6
mknod /dev/carmel/2p7 b 160 71 # drive 2 partition 7
mknod /dev/carmel/2p8 b 160 72 # drive 2 partition 8
mknod /dev/carmel/2p9 b 160 73 # drive 2 partition 9
mknod /dev/carmel/2p10 b 160 74 # drive 2 partition 10
mknod /dev/carmel/2p11 b 160 75 # drive 2 partition 11
mknod /dev/carmel/2p12 b 160 76 # drive 2 partition 12
mknod /dev/carmel/2p13 b 160 77 # drive 2 partition 13
mknod /dev/carmel/2p14 b 160 78 # drive 2 partition 14


So, you will be running fdisk(or your preferred disk utility) on 
/dev/carmel/[0-7]

your mount points are 
/dev/carmel/[0-7][0-255]


here is the perl script.
reply to me here, or send me email at me -at- michaelgregg.com if you want 
me to email you the perl script, or the shell script separately.












#!/usr/bin/perl
                                                                                                                                       
$nodfile = "./carmel-make-node"; #name of shell script to write to
                                                                                                                                       
open (NODF, ">$nodfile");
                                                                                                                                       
$inc = 0; # minor number to be incremeted
                                                                                                                                       
for ($x=0;$x<=7;$x++)
{
        print NODF "mknod /dev/carmel/$x b 160 $inc # drive $x\n"; # whole 
disk device, use this, or run fdisk on it.
        $inc++;
        for ($y=1;$y<=31;$y++)
        {
                print NODF "mknod /dev/carmel/$x"; # output the devices 
for every partition for the main devices
                print NODF "p$y b 160 $inc # drive $x partition $y\n";
                $inc++;
        }
}
                                                                                                                                       
# repeat the above process for drives 8-15, if you have two cards in the 
machine.
                                                                                                                                       
for ($x=8;$x<=15;$x++)
{
        print NODF "mknod /dev/carmel/$x b 161 $inc # drive $x\n";
        $inc++;
        for ($y=1;$y<=31;$y++)
        {
                print NODF "mknod /dev/carmel/$x";
                print NODF "p$y b 161 $inc # drive $x partition $y\n";
                $inc++;
        }
}
                                                                                                                                       
close NODF;

