Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264398AbRFNCA6>; Wed, 13 Jun 2001 22:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264400AbRFNCAs>; Wed, 13 Jun 2001 22:00:48 -0400
Received: from sunny-legacy.pacific.net.au ([210.23.129.40]:65533 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S264398AbRFNCAc>; Wed, 13 Jun 2001 22:00:32 -0400
Message-Id: <200106140200.f5E20NL3012987@typhaon.pacific.net.au>
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: "Rainer Mager" <rmager@vgkk.com>
cc: linux-kernel@vger.kernel.org
Subject: Download process for a "split kernel" (was: obsolete code must die) 
In-Reply-To: Message from "Rainer Mager" <rmager@vgkk.com> 
   of "Thu, 14 Jun 2001 10:45:10 +0900." <NEBBJBCAFMMNIHGDLFKGCEFCEEAA.rmager@vgkk.com> 
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGCEFCEEAA.rmager@vgkk.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 14 Jun 2001 12:00:23 +1000
From: David Luyer <david_luyer@pacific.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> I agree that removing support for any hardware is a bad idea but I question
> the idea of putting it all in one monolithic download (tar file). If we're
> considering the concern for less developed nations with older hardware,
> imagine how you would like to download the whole kernel with an old 2400 bps
> modem. Not a fun thought.
> 
> Would it make sense to create some sort of 'make config' script that
> determines what you want in your kernel and then downloads only those
> components? After all, with the constant release of new hardware, isn't a
> 50MB kernel release not too far away? 100MB?

This might actually make sense - a kernel composed of multiple versioned
segments.  A tool which works out dependencies of the options being selected,
downloads the required parts if the latest versions of those parts are not
already downloaded, and then builds the kernel (or could even build during
the download, as soon as the build dependencies for each block of the kernel
are satisfied, if you want to be fancy...).  

Or as a simpler design, something like;

  * a copy of the kernel maintained in a CVS tree
  * kernel download would pull down:
        * the build script
        * a file containing the list of filenames depended on by
          each config option
  * build script builds the config and then cvs updates the file list
    and the files for each config option in question to the version as
    tagged in the build script

Someone could relatively easily maintain this separate to all the kernel 
developers, and it would mean only ever having to download files you were
actually using.

David.
-- 
David Luyer                                        Phone:   +61 3 9674 7525
Engineering Projects Manager   P A C I F I C       Fax:     +61 3 9699 8693
Pacific Internet (Australia)  I N T E R N E T      Mobile:  +61 4 1111 2983
http://www.pacific.net.au/                         NASDAQ:  PCNTF


