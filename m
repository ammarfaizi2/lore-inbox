Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131063AbRC3H3w>; Fri, 30 Mar 2001 02:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131158AbRC3H3m>; Fri, 30 Mar 2001 02:29:42 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:64526 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131063AbRC3H3d>;
	Fri, 30 Mar 2001 02:29:33 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Chris Funderburg" <chris@directcommunications.net>
cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>,
   "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: memcpy in 2.2.19 
In-Reply-To: Your message of "Fri, 30 Mar 2001 08:04:17 +0100."
             <CHEEIAEEAIFDOCGJIAKPOEDCCJAA.chris@directcommunications.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 29 Mar 2001 23:28:37 -0800
Message-ID: <7717.985937317@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2001 08:04:17 +0100, 
"Chris Funderburg" <chris@directcommunications.net> wrote:
>drivers/scsi/scsi.a(aic7xxx.o): In function `aic7xxx_load_seeprom':
>aic7xxx.o(.text+0x116bf): undefined reference to `memcpy'

Under some circumstances gcc will generate an internal call to
memcpy().  Alas this bypasses the pre-processor so memcpy is not
converted to the kernel's internal memcpy code.  The cause is normally
a structure assignment, probably this line.

  struct seeprom_config *sc = (struct seeprom_config *) scarray;

Try this replacement

  struct seeprom_config *sc;
  memcpy(sc, scarray, sizeof(*sc));

The other possibility I can see is

    p->sc = *sc;

try

    memcpy(&(p->sc), sc, sizeof(*sc));

