Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264163AbTDJUes (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 16:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264162AbTDJUes (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 16:34:48 -0400
Received: from hera.cwi.nl ([192.16.191.8]:41914 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264161AbTDJUep (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 16:34:45 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 10 Apr 2003 22:46:23 +0200 (MEST)
Message-Id: <UTC200304102046.h3AKkNl01295.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       pbadari@us.ibm.com
Subject: Re: Isn't sd_major() broken ?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Badari Pulavarty <pbadari@us.ibm.com>

    I am little confused about the correctness of sd_major()
    in drivers/scsi/sd.c.

    Isn't sd_major() broken ? Here is the patch to fix it.

    --- drivers/scsi/sd.c.org    Wed Apr  9 13:12:38 2003
    +++ drivers/scsi/sd.c    Thu Apr 10 11:01:45 2003
    @@ -123,7 +123,7 @@ static int sd_major(int major_idx)
         case 1 ... 7:
             return SCSI_DISK1_MAJOR + major_idx - 1;
         case 8 ... 15:
    -        return SCSI_DISK8_MAJOR + major_idx;
    +        return SCSI_DISK8_MAJOR + major_idx - 8;
         default:
             BUG();
             return 0;    /* shut up gcc */

Yes.

The sd_major() patch was from hch in 2.5.51 - maybe you are
the first to use more than 8 majors.

Andries
