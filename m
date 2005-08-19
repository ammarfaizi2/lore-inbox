Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932614AbVHSKkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbVHSKkb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 06:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbVHSKkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 06:40:31 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:392 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932614AbVHSKkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 06:40:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=WNWUSRse750WToRKTYTfz2qqc4riYK1JzpSEOiF4AtVbMu7vd4TqIZWUbWOMgnk7tNb2pfMsD1h/s4RKy6aYFOD5nd3jPoHDOIPvhvx1jmQ1CWJQe7Seg1F3NryZVCzc4O+j9Z2ktalqzku6RjQK74HwMLTO1i+uxE1NmjDXZyg=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Molnar <mingo@elte.hu>, Chuck Harding <charding@llnl.gov>
Subject: Re: 2.6.13-rc6-rt9
Date: Fri, 19 Aug 2005 12:41:39 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508191241.39340.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck wrote:
> I'm still getting the same oops when rebooting. the same process (reboot)
> similar call trace (some addresses are slightly different but the functions
> are the same:
> disable_IO_APIC+0x5a/0x90 (8)
> machine_restart+0x5/0x9 (28)
> sys_reboot+0x147/0x156 (4)
> netdev_run_todo+0xa4/0x209 (4)
> etc.

Does this patch help?

------
diff -up arch/i386/kernel/io_apic.c.rt9 arch/i386/kernel/io_apic.c
--- arch/i386/kernel/io_apic.c.rt9      2005-08-19 12:28:42.000000000 +0200
+++ arch/i386/kernel/io_apic.c  2005-08-19 12:29:30.000000000 +0200
@@ -1758,8 +1758,8 @@ void disable_IO_APIC(void)
                 * Add it to the IO-APIC irq-routing table:
                 */
                spin_lock_irqsave(&ioapic_lock, flags);
-               io_apic_write(0, 0x11+2*pin, *(((int *)&entry)+1));
-               io_apic_write(0, 0x10+2*pin, *(((int *)&entry)+0));
+               io_apic_write(ioapic_data[0], 0x11+2*pin, *(((int *)&entry)+1));
+               io_apic_write(ioapic_data[0], 0x10+2*pin, *(((int *)&entry)+0));
                spin_unlock_irqrestore(&ioapic_lock, flags);
        }
        disconnect_bsp_APIC(pin != -1);
------

   Karsten

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
