Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277412AbRJEOsE>; Fri, 5 Oct 2001 10:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277398AbRJEOry>; Fri, 5 Oct 2001 10:47:54 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:37454
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S277407AbRJEOrs>; Fri, 5 Oct 2001 10:47:48 -0400
Message-Id: <200110051447.f95ElUj01488@localhost.localdomain>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Dave Cinege <dcinege@psychosis.com>
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: Re: [POT] Linux SAN?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Oct 2001 09:47:30 -0500
From: James Bottomley <James.Bottomley@SteelEye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The FC HBA driver put out by Qlogic works well but does a silly thing;
> it  enumerates devices from 0, instead of by the actually loop ID.
> This makes  it impossible to spec absolute paths to the device, as
> everything will shift when devices are moved on the FC loop.

There are several reasons why this is done:

Most modern SANs use soft loop ID which means that the ID is determined at 
login time to the SAN, so changes as the SAN composition changes, therefore 
the loop ID isn't really meaningful anyway.

FC drivers are coming around to the notion of persistent binding, which is 
where you try to identify your devices by WWN instead of loop ID.  This is 
usually implemented as a mapping function which assigns a known SCSI pun to a 
particular WWN regardless of the actual loop ID.

Version 5.x of the qla2x00 driver (in SuSE 7.3 and also on the IBM website but 
not the qlogic website [yet]) does arbitrated loop.  Now, since arbitrated 
loop has two or more paths to the device through different ports with possibly 
different loop IDs, which loop ID would you use as the "actual" one?

James Bottomley


