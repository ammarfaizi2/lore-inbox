Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbVIGSle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVIGSle (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 14:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVIGSle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 14:41:34 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:30173 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932210AbVIGSld
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 14:41:33 -0400
Subject: Re: [patch 0/4] ide: Break ide_lock to per-hwgroup lock
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>
In-Reply-To: <20050907181654.GB3769@localhost.localdomain>
References: <20050906233322.GA3642@localhost.localdomain>
	 <1126112950.8928.18.camel@localhost.localdomain>
	 <20050907181654.GB3769@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 07 Sep 2005 20:06:14 +0100
Message-Id: <1126119974.8928.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-09-07 at 11:16 -0700, Ravikiran G Thirumalai wrote:
> I tested it on a 2way box with a piix controller. It got through Bonnie++.  
> I have access to piix controllers only, so that was the only controller 
> I changed.  I did not read the errata though... :(

Errata matter a lot unfortunately - older IDE controllers commonly have
bugs where changing the set up of one interface affects the other even
if a transfer is occuring.

> Do you think the approach is unsafe, even if the piix tune routine is
> serialized with a per-driver lock?  Bartlomiej?

If the documents/errata for the chips are checked then I can see it
making sense. I do worry that it may introduce other races because the
IDE locking is such a mess but that would be true of any change and
eventually has to be addressed.

I think it makes sense, with corrections.

