Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263524AbRFAOBD>; Fri, 1 Jun 2001 10:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263523AbRFAOAx>; Fri, 1 Jun 2001 10:00:53 -0400
Received: from [203.34.97.3] ([203.34.97.3]:15364 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S263527AbRFAOAp>;
	Fri, 1 Jun 2001 10:00:45 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Matt Chapman <matthewc@cse.unsw.edu.au>
cc: Dag Brattli <dag@brattli.net>, linux-kernel@vger.kernel.org,
        linux-irda@pasta.cs.uit.no
Subject: Re: [PATCH] for Linux IRDA initialisation bug 2.4.5 
In-Reply-To: Your message of "Fri, 01 Jun 2001 23:32:46 +1000."
             <20010601233245.A10478@cse.unsw.edu.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Jun 2001 23:59:13 +1000
Message-ID: <6679.991403953@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jun 2001 23:32:46 +1000, 
Matt Chapman <matthewc@cse.unsw.edu.au> wrote:
>I've found that if you compile IRDA into the kernel, irda_proto_init
>gets called twice - once at do_initcalls time, and once explicitly
>in do_basic_setup - eventually resulting in a hang (as
>register_netdevice_notifier gets called twice with the same struct,
>and it's list becomes circular).

The suggested patch has one non-obvious side effect which somebody in
irda needs to verify is OK.  Previously irda_proto_init() and
irda_device_init() were called after every other driver had
initialized.  Now irda_proto_init() is called based on the object order
in the top level Makefile, so irda is initialized before i2c,
telephony, acpi and mddev.  Is this a valid initialization order?  If
not, move

  DRIVERS-$(CONFIG_IRDA) += drivers/net/irda/irda.o

to the end of the drivers list and document why it needs to be there.

