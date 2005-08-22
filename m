Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbVHVV0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbVHVV0J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVHVV0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:26:05 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:64237 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751028AbVHVVZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:25:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=QYh/GKi+zsAHl2gu4uzQTL6LAVWRl0aw3PC6PQOTbhB7ciPUbQg2bxRYl6a0JfXW0baGTA4qSGjsZKFAJD7ZAY+rX6IoC4jq32mxbYm8vmTMIoEDwizAd4vWmKTKf2k+ov6AJEGchPBCypeCyLM02qTK9+Ox471TqvoJMU5xPYo=  ;
Message-ID: <20050822140634.92263.qmail@web51612.mail.yahoo.com>
Date: Mon, 22 Aug 2005 07:06:33 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: [PATCH 2.6.12.5 1/2] lib: allow idr to be used in irq context
To: James Bottomley <James.Bottomley@SteelEye.com>, luben_tuikov@adaptec.com
Cc: Andrew Morton <akpm@osdl.org>, Jim Houston <jim.houston@ccur.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <1124640387.5068.2.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- James Bottomley <James.Bottomley@SteelEye.com> wrote:
> On Sun, 2005-08-21 at 08:49 -0700, Luben Tuikov wrote:
> > The caller is the aic94xx SAS LLDD.  It uses IDR to generate unique
> > task tag for each SCSI task being submitted.  It is then used to lookup
> > the task given the task tag, in effect using IDR as a fast lookup table.
> > 
> > Yes, I'm also not aware of any other users of IDR from mixed process/IRQ
> > context or for SCSI Task tag purposes.
> 
> Just a minute, that's not what idr was designed for.  It was really
> designed for enumerations (like disk) presented to the user.  That's why
> using it in IRQ context hasn't been considered.

Hi James, how are you?

Is this the only use _you_ could find for a *radix tree*? ;-)
Since of course sd.c uses it just as an enumeration, according to
you this must be the only use? :-)

It was designed as a general purpose id to pointer translation
service, just as the comment in it says.

> However, there is an infrastructure in the block layer called the
> generic tag infrastructure which was designed precisely for this purpose
> and which is designed to operate in IRQ context.

James, I'm sure you're well aware that,
   - a request_queue is LU-bound,
   - a SCSI _transport_ (*ANY*) can _only_ address domain devices, but
     _not_ LUs.  LUs are *not* seen on the domain.

See the different associations?  Then why are you posting such emails?

Andrew, please apply this patch.

Thanks,
     Luben

