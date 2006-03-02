Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752108AbWCCHcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbWCCHcP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 02:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbWCCHcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 02:32:15 -0500
Received: from www.starshine.org ([216.240.40.167]:11189 "EHLO
	mx.starshine.org") by vger.kernel.org with ESMTP id S1752108AbWCCHcP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 02:32:15 -0500
Date: Thu, 2 Mar 2006 13:49:29 -0800
To: linux-kernel@vger.kernel.org
Subject: SEEK_HOLE and SEEK_DATA support?
Message-ID: <20060302214929.GA16523@starshine.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
From: jimd@starshine.org (Jim Dennis)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 All,

 Has there been any thought about adding SEEK_HOLE and SEEK_DATA (*)
 support to Linux?  

 I ask primarily because of the interplay between 64-bit systems and
 things like /var/log/lastlog (which appears as a 1.2TiB file due to
 the nfsnobody UID of 4294967294).

 (I'm realize that adding support for these additional seek() flags
 wouldn't solve the problem ... archiving tools would still have to
 implement it.  And I can also hear the argument that Red Hat and other
 distributions should re-implement lastlog handling to use a more modern
 and efficient hashing/index format and perhaps that they should set
 nfsnobody to "-1" ... I'd be curious if those details are driven by
 some published standard or if they are artifacts of porting.  I'd also
 be curious what's happened with other 64-bit UNIX ports and whether
 this issue ever came up in Linux ports to the Alpha or other 64-bit
 processors).

 As a stray data point I just did a quick experiment and just doing
 a time cat /var/log/lastlog > /dev/null took about:

 36.33user 2453.99system 41:35.90elapsed 99%CPU 
    (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (133major+15minor)pagefaults 0swaps


 On an otherwise idle 2GHz dual Opteron (yes, of course the extra
 CPU is wasted for this job), reading SCSI disk hanging off a Fusion MPT 
 controller.

 From what I hear our Networker processes pore over these NULs for about
 two hours any time someone fails to exclude /var/log/lastlog from their
 backup list.

 * (see http://blogs.sun.com/roller/page/bonwick?entry=seek_hole_and_seek_data
    for details)


 (Please feel free to cc me on any responses, or I'll pick them up via
 the archives and KT ... my account dropped off LKML years ago and I
 don't want to punish my poor old IDSL line with the traffic now)

-- 
Jim Dennis
