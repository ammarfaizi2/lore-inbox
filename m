Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266280AbRGJMla>; Tue, 10 Jul 2001 08:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266282AbRGJMlU>; Tue, 10 Jul 2001 08:41:20 -0400
Received: from hypnos.cps.intel.com ([192.198.165.17]:5865 "EHLO
	hypnos.cps.intel.com") by vger.kernel.org with ESMTP
	id <S266280AbRGJMlC>; Tue, 10 Jul 2001 08:41:02 -0400
Message-ID: <9678C2B4D848D41187450090276D1FAE0635F135@FMSMSX32>
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: "'Douglas Gilbert'" <dougg@torque.net>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RE: [PATCH-2.4.3] scsi logging
Date: Tue, 10 Jul 2001 05:40:23 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


DG> I would object to point 3). SANE, and to a lesser extent
DG> cdrecord, execute lots of commands that give SCSI check
DG> conditions and would bloat the log and the console with
DG> many serious looking messages. [...]

Doug,

Would it be possible to recognize & filter the specific errors output by
SANE and cdrecord rather than removing all sg sense errors?  Or to ignore
all but certain sense codes unless SG_SET_DEBUG is set?
What I'm most concerned about is to make sure that any media problems on
fixed disks (03/11/00, etc.) don't get missed.  

Perhaps something like: 
if (CHECK_CONDITION ...) {
  if ((type == disk && (key == MEDIUM_ERROR || key == HARDWARE_ERROR))
     || (sdp->sgdebug > 0))
        print_req_sense(...)
  }
How about that?

Andy


