Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290536AbSAQXsR>; Thu, 17 Jan 2002 18:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290537AbSAQXsG>; Thu, 17 Jan 2002 18:48:06 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:18327 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290536AbSAQXrv>; Thu, 17 Jan 2002 18:47:51 -0500
Subject: Re: FC & MULTIPATH !? (any hope?)
From: Brian Beattie <alchemy@us.ibm.com>
To: Mario Mikocevic <mozgy@hinet.hr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020114123301.B30997@danielle.hinet.hr>
In-Reply-To: <20020114123301.B30997@danielle.hinet.hr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 17 Jan 2002 15:36:54 -0800
Message-Id: <1011310615.519.3.camel@w-beattie1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-14 at 03:33, Mario Mikocevic wrote:
> Hi,
> 
> is there any hope of working combination of MULTIPATH with FC !?
> 
> At the moment I am using raid option multipath but it's one way
> street, when one FC connection dies it successfully switches onto
> another FC connection but when that second dies aswell, mount point
> is in a limbo, no switching back to first FC connection.
> 
> Any other solutions, patches ?!
> 

After analysing the current code in md/multipath and discussing it with
other here who have experience with multipath support I have come up
with the following approach.

When a path fails and there are no more good paths, an attempt will be
made complete the operation using each previously failed path untill the
operation succeds, or all know paths have been tried.  If the operation
succeds, that path will be marked good.

When a operation is attempted and no good paths exist, the operation
will be attempted on each know path until success or all know paths are
tried.

Probable enhancements to this would include, provideing a method to mark
a path to not attempt this crude form of auto recovery and a way to mark
a failed path as good.  Finally a device wide flag to disable
auto-recovery.

A disadvantage to this approach is that it would potentially, multiply
the amount or time it takes to ultimately fail the attempt, by the
number of paths.  This would seem to be acceptable since the alternative
is to fail the operation when a good route might exist.

I would appreciate any thoughts, flames, or suggestions.

