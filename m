Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261401AbSKTPtw>; Wed, 20 Nov 2002 10:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbSKTPtv>; Wed, 20 Nov 2002 10:49:51 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:58057 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261401AbSKTPto>;
	Wed, 20 Nov 2002 10:49:44 -0500
Importance: Normal
Sensitivity: 
Subject: Re: RFC - new raid superblock layout for md driver
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4  June 8, 2000
Message-ID: <OF6B381288.73386F52-ON85256C77.00543682@pok.ibm.com>
From: "Steve Pratt" <slpratt@us.ibm.com>
Date: Wed, 20 Nov 2002 09:55:55 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 11/20/2002 10:56:38 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Neil Brown wrote;

>I would like to propose a new layout, and to receive comment on it..


 >/* constant this-device information - 64 bytes */
    >u64  address of superblock in device
    >u32  number of this device in array  /* constant over reconfigurations
    */

 Does this mean that there can be holes in the numbering for disks that die
    and are replaced?

    >u32  device_uuid[4]
    >u32  pad3[9]

 >/* array state information - 64 bytes */
    >u32  utime
    >u32  state    /* clean, resync-in-progress */
    >u32  sb_csum

 These next 2 fields are not 64 bit aligned. Either rearrange or add
    padding.

    >u64  events
    >u64  resync-position     /* flag in state if this is valid)
    >u32  number of devices
    >u32  pad2[8]



>Other features:
   >A feature map instead of a minor version number.

Good.

   >64 bit component device size field.

Size in sectors not blocks please.


   >no "minor" field but a textual "name" field instead.

Ok, I assume that there will be some way for userspace to query the minor
   which gets dynamically assigned when the array is started.

   >address of superblock in superblock to avoid misidentifying superblock.
   e.g. is it >in a partition or a whole device.

Really needed this.


>The interpretation of the 'name' field would be up to the user-space
>tools and the system administrator.

Yes, so let's leave this out of this discussion.


EVMS 2.0 with full user-space discovery should be able to support the new
superblock format without any problems. We would like to work together on
this new format.

Keep up the good work, Steve



