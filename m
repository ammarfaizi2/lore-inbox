Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTJXP5k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 11:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbTJXP5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 11:57:40 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:46799 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262324AbTJXP5h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 11:57:37 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Martin Waitz <tali@admingilde.org>, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net, dm-devel@sistina.com
Subject: Re: [Evms-devel] device-mapper & bd_claim
Date: Fri, 24 Oct 2003 10:56:27 -0500
User-Agent: KMail/1.5
References: <20031024115632.GX9850@admingilde.org>
In-Reply-To: <20031024115632.GX9850@admingilde.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310241056.27456.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 October 2003 06:56, Martin Waitz wrote:
> hi :)
>
> i use evms to mount some filesystems.
> the root filesystem is located on /dev/hda1, all other partitions
> are managed by evms.
>
> this works without problems in 2.4.
> however, evms refuses to create the logical volumes in 2.6.
>
> the problem seems to be the addition of bd_claim in 2.6:
> upon mounting the root filesystem, hda1 is claimed by the filesystem.
> thus, hda is claimed by the bd_claim code, too.
> evms tries to setup dm-tables using hda and fails to claim the device
>
> so, how should this be solved?
> i think it should be allowed to mix evms and 'normal' partitions on
> the same device.
>
> do we need to introduce claimed_region of the toplevel device instead
> of claiming individual devices?

Please see the notes at the top of:
http://evms.sourceforge.net/patches/2.1.1/kernel/2.6.0-test8/bd_claim.patch

In general, if you want to "mix" users of a device, you'll just need to revert 
that patch. But this isn't the preferred solution. If you're using EVMS, 
ideally you should switch to using EVMS for all your volumes and partitions. 
Getting your root filesystem mounted through EVMS isn't terribly difficult, 
and you can find more details about it at:
http://evms.sourceforge.net/install/root.html

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

