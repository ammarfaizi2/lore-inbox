Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130232AbQKKJty>; Sat, 11 Nov 2000 04:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130473AbQKKJto>; Sat, 11 Nov 2000 04:49:44 -0500
Received: from lioth.frs.linpro.no ([193.212.244.34]:65035 "EHLO
	lioth.frs.linpro.no") by vger.kernel.org with ESMTP
	id <S130232AbQKKJtf> convert rfc822-to-8bit; Sat, 11 Nov 2000 04:49:35 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [bug] usb-uhci locks up on boot half the time
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDC82@orsmsx31.jf.intel.com>
	<3A0B27E3.7D10AB64@linux.com>
From: hnh@linpro.no (Harald Nordgård-Hansen)
Date: 11 Nov 2000 10:49:31 +0100
In-Reply-To: David Ford's message of "Thu, 09 Nov 2000 14:40:36 -0800"
Message-ID: <xonhf5en8ic.fsf@ruth.frs.linpro.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford <david@linux.com> writes:
> The oddity is that kdb shows the machine to lock up on the popf in
> pci_conf_write_word()+0x2c.  I never did get around to digging up this
> routine and looking at the code, but I suspect this is a final return
> from the routine.  I'm rather confused however, I have no idea why a
> flags pop would hang the hardware.

I've got a machine here that locks solid every time with -test10.  It
locks up towards the end of start_uhci, where it calls:
----
/* disable legacy emulation */
pci_write_config_word (dev, USBLEGSUP, USBLEGSUP_DEFAULT);
----

Now, disabling this call seems to make the system work perfectly.  The
machine is a Celeron 500 / Asus P3B-F (I think, it's at the office).
Also -test8 works, I haven't tried any of the test11-pre* versions yet.

Any things I should try to test?  (Please CC me, as I don't have the
time to follow linux-kernel as closely as I would like at the moment.)

-Harald
-- 
Harald Nordgård-Hansen, Linpro AS  <><  http://www.linpro.no/~hnh/
PB. 375, N-1601 Fredrikstad, Norway    Phone/Fax: +47 6935 2424/25
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
