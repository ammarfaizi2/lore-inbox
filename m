Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTJ3IrH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 03:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbTJ3IrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 03:47:07 -0500
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:63940 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S262288AbTJ3IrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 03:47:04 -0500
Subject: Re: Ref-count problem in kset_find_obj?
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF17955FFB.636D4146-ONC1256DCF.002FBB36-C1256DCF.003038FC@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Thu, 30 Oct 2003 09:46:43 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 30/10/2003 09:46:50
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Yes, you're right. The function is pretty much unused, and I don't have
a
> > problem removing it, provided we can fix up the one user
> > (arch/i386/kernel/edd.c). Unless of course, you're planning on using
it..
>
> At the moment, edd.c doesn't actually use it.  It wants to -
> find_bus() is a useful concept, but I haven't proven that the scsi_bus
> list only has scsi_devices on it, so that code isn't compiled in at
> present.  If the scsi_bus list is clean now, then yes, I'll want to
> turn it back on (after 2.6.0 is out) and will need find_bus() to be
> possible.

We don't plan to use kset_find_obj in the near future but since Matt
wants to use it, better fix it. The fix should be easy just add a
kobject_get and make the caller of kset_find_obj return the reference
again.

blue skies,
   Martin


