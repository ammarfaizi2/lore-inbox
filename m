Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316430AbSILPhP>; Thu, 12 Sep 2002 11:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSILPhP>; Thu, 12 Sep 2002 11:37:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38161 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316430AbSILPhP>; Thu, 12 Sep 2002 11:37:15 -0400
Date: Thu, 12 Sep 2002 16:42:01 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Mike Anderson <andmike@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 SCSI core bug?
Message-ID: <20020912164201.A3121@flint.arm.linux.org.uk>
References: <20020911221859.A17951@flint.arm.linux.org.uk> <20020912100140.A32196@flint.arm.linux.org.uk> <20020912153923.GA8295@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020912153923.GA8295@beaverton.ibm.com>; from andmike@us.ibm.com on Thu, Sep 12, 2002 at 08:39:23AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2002 at 08:39:23AM -0700, Mike Anderson wrote:
> I have a cleanup patch for 2.5 scsi_error I will add this fix in.
> scsi_send_eh_cmnd should not be retrying the command it should return to
> the caller the status and let them decide. We also should create a
> ?restore_scsi_cb? function that is shared so that it is done
> consistently.

I've got a patch for both of these now.  I'm working through some other
issues at the moment though (like, why the hell requests for sectors
after the sector in error don't have a data phase, and the drive returns
status = GOOD, message = COMMAND COMPLETE, leading the kernel to believe
that it did transfer data.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

