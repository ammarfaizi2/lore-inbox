Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbSKTUEV>; Wed, 20 Nov 2002 15:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbSKTUEV>; Wed, 20 Nov 2002 15:04:21 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:48268 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262224AbSKTUES>;
	Wed, 20 Nov 2002 15:04:18 -0500
Date: Wed, 20 Nov 2002 12:11:17 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [BUG] 2.5.47: sysfs hierarchy can begin to disintegrate
Message-ID: <20021120121117.A21414@eng2.beaverton.ibm.com>
References: <200211200925.gAK9Pl002345@owlet.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200211200925.gAK9Pl002345@owlet.beaverton.ibm.com>; from ricklind@us.ibm.com on Wed, Nov 20, 2002 at 01:25:47AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 01:25:47AM -0800, Rick Lindsley wrote:

> Interesting observation: the megaraid controller has some problem right
> now (suspected to be hardware) wherein its scsi disks appear at boot
> time but then cannot be accessed later and are subsequently detached.
> Since this could well be a little-used and little-tested path, my
> suspicion is that either the megaraid, scsi, or sysfs code has a bug when
> disks are detached.  So far, I've not been able to find one, however, so

Regarding megaraid, Stephen Hemming and Mark Haverkamp posted about
problems, leading to this:

http://marc.theaimsgroup.com/?l=linux-scsi&m=103728900228366&w=2

Generally - the megaraid had problems, where the aic driver did not using
the same disk drives. AFAICT the megaraid caused a problem, and its error
handling is non existent, so it is unable to recover from the problem. I'm
sure Mark or Stephen could provide details.

> I thought I'd report this in case others might know just where to peek.
> Could it be that removing entries from sysfs is done incorrectly in
> some cases?

If you are talking about rmmod your-scsi-adapter, or removing a scsi_device
vi /proc/scsi, yes, there are problems in sysfs and in scsi. None of the
sysfs fixes are in the current bk tree, I assume Pat Mochel needs to push
them (he hasn't been online recently).

We can push a simple scsi fix (via James B), but the scsi sysfs code is not
good, Mike Anderson is working on some patches for that.

-- Patrick Mansfield
