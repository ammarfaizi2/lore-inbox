Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261628AbRFLO6k>; Tue, 12 Jun 2001 10:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261639AbRFLO63>; Tue, 12 Jun 2001 10:58:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7580 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261651AbRFLO6U>;
	Tue, 12 Jun 2001 10:58:20 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15142.11764.844524.381111@pizda.ninka.net>
Date: Tue, 12 Jun 2001 07:57:56 -0700 (PDT)
To: DJBARROW@de.ibm.com
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: bug in /net/core/dev.c
In-Reply-To: <C1256A69.004E9AF2.00@d12mta09.de.ibm.com>
In-Reply-To: <C1256A69.004E9AF2.00@d12mta09.de.ibm.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


DJBARROW@de.ibm.com writes:
 > On 390 it is very easy to hotplug devices under VM.
 > 
 > We do it all the time using the channel device layer on s/390, so users
 > can reconfigure devices if they misconfigure them.
 > 
 > If it can be registered it should be able to be unregistered.
 > 
 > Cornelia Huck in our group in boeblingen noticed the bug too.

I still think it's bogus.  Those "early init of device" messages
should only be occurring for specific legacy ISA device drivers,
and for nothing else.

You need to find a way to link in the S390 network drivers after the
net/ module so that the drivers run their init after net_dev_init()
runs.

Sure, this refcount thing is a bug, and I will look at your patch, but
you need to make your normal net devices get init'd after
net_dev_init() runs.

Later,
David S. Miller
davem@redhat.com
