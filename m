Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264312AbTEOXDJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 19:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264311AbTEOXDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 19:03:09 -0400
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:60165 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP id S264310AbTEOXDD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 19:03:03 -0400
Message-ID: <3EC41FC9.4050504@torque.net>
Date: Fri, 16 May 2003 09:16:25 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [patch] NCR5380.c fix
References: <UTC200305152245.h4FMjAj26766.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200305152245.h4FMjAj26766.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> Several SCSI drivers confuse CHECK_CONDITION and CHECK_CONDITION << 1.
<snip>

Linux has always had SCSI status values that are masked
(reasonable) and shifted one bit right (bizarre) from
the equivalent values in the SCSI standards. This
has tricked lots of people.

So in lk 2.5 saner defines (with long-winded names)
have been introduced:
....
#define SAM_STAT_CHECK_CONDITION 0x02
....

The appropriate mask is now 0x7e since Linux uses
the upper bytes and the vendor could (but seldom)
use bits 0 and 7. We should have a constant or macro
for this mask.

So in lk 2.5 your check could read:

    if ((cmd->SCp.Status & 0x7e) == SAM_STAT_CHECK_CONDITION)


Aside: "SAM" stands for SCSI Architecture Model which is the
modern standard that defines SCSI status values.

Doug Gilbert


