Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318208AbSG3DCd>; Mon, 29 Jul 2002 23:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318209AbSG3DCc>; Mon, 29 Jul 2002 23:02:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:38637 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318208AbSG3DCb>;
	Mon, 29 Jul 2002 23:02:31 -0400
Date: Mon, 29 Jul 2002 19:54:14 -0700 (PDT)
Message-Id: <20020729.195414.31386335.davem@redhat.com>
To: remco@rvt.com
Cc: dan@embeddededge.com, benh@kernel.crashing.org, trini@kernel.crashing.org,
       rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: 3 Serial issues up for discussion
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200207291246.43134.remco@rvt.com>
References: <20020729181352.27999@192.168.4.1>
	<3D4592D3.50505@embeddededge.com>
	<200207291246.43134.remco@rvt.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Remco Treffkorn <remco@rvt.com>
   Date: Mon, 29 Jul 2002 12:46:42 -0700
   
   Drivers need not fight about minor numbers. That can be simply handled:
   
   int get_new_serial_minor()
   {
       static int minor;
   
       return minor++;
   }
   
   Any serial driver can call this when it initializes a new uart.
   Hot pluggable drivers have to hang on to their minors, and
   re-use.

I don't think it's wise to make hot-plug drivers keep track
of the minors they ever use in such a sloppy way.  Why not
make the get_new_serial_minor() thing have a release method
too and then we can keep track of minor allocation in one
place.

Also if I remmove the module for a serial port driver, those minors
should get reused by the next registered uart too.

Finally we can name this all /dev/serialXXX in keeping with Linus's
grand view of /dev/diskXXX et al. (and keeping ttySfoo around for
compat sake for a little while of course :).
