Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261403AbSIZPmZ>; Thu, 26 Sep 2002 11:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261404AbSIZPmZ>; Thu, 26 Sep 2002 11:42:25 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:42745
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261403AbSIZPmZ>; Thu, 26 Sep 2002 11:42:25 -0400
Subject: Re: [PATCH-RFC] 4 of 4 - New problem logging macros, SCSI RAID
	device driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Larry Kessler <kessler@us.ibm.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith " "Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <3D8FCC53.3070809@pobox.com>
References: <3D8FC5BC.51A8FCCF@us.ibm.com>  <3D8FCC53.3070809@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Sep 2002 16:52:00 +0100
Message-Id: <1033055520.11848.49.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-24 at 03:22, Jeff Garzik wrote:
> If you actually want to standardize some diagnostic messages, it is a 
> huge mistake [as your scsi driver example shows] to continue to use 
> random text strings followed by a typed attribute list.  If you really 
> wanted to standardize logging, why continue to allow driver authors to 
> printk driver-specific text strings in lieu of a standard string that 
> applies to the same situation in N drivers.

A lot of it can be tidied up by very very few changes that can be done
over time and make the job easier. Why not just start with

	dev_printk(dev, KERN_ERR "Exploded mysteriously");

and a few notification type things people can add eg

	dev_failed(dev);
	dev_offline(dev);

much like we keep network status. That lets driverfs tell the decision
making code in hotplug scripts the state of play and lets it figure out
how to reassign resources, paper over cracks, phone the engineer.

Alan

