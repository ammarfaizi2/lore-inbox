Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbVKRW6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbVKRW6I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 17:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbVKRW6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 17:58:08 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:53032 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751079AbVKRW6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 17:58:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer;
        b=q6v8UP+aL8UYGvjg4+uTUtxDI1X2GnFksz+54CkUI5TpjIBrhl3HBk4x0OReAG9QjUchWFINQ16cZPEpcXTVLLRsqi9ELDL0Uf+UOo0zc3tblWarYt4VJji45hjPDsrvnKAXCp6DKBgyp0HDzoqkriRZrtsfRWOVIoAzbyo6E8A=
Subject: re: 2.6.15-rc1-mm2 - strace unhappy
From: Badari Pulavarty <pbadari@gmail.com>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051118205741.97473.qmail@web34113.mail.mud.yahoo.com>
References: <20051118205741.97473.qmail@web34113.mail.mud.yahoo.com>
Content-Type: multipart/mixed; boundary="=-uGyjG8Cw2tksbTA1C5pf"
Date: Fri, 18 Nov 2005 14:58:01 -0800
Message-Id: <1132354681.24066.192.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uGyjG8Cw2tksbTA1C5pf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-11-18 at 12:57 -0800, Kenny Simpson wrote:
> strace causes the kernel to croak:
> 
> cd /tmp
> strace ls
> *BOOM*
> 
> Nov 18 15:44:31 tux6127 kernel: [  221.522945] c0126b5b
> Nov 18 15:44:31 tux6127 kernel: [  221.523069] PREEMPT SMP DEBUG_PAGEALLOC
> Nov 18 15:44:31 tux6127 kernel: [  221.523268] Modules linked in: autofs4 parport_pc parport
> floppy rtc i2c_i801 i2c_core generic usbhid uhci_hcd tg3 snd_intel8x0 snd_ac97_codec snd_ac97_bus
> snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd usbcore mousedev
> e1000 bcm5700 unix
> Nov 18 15:44:31 tux6127 kernel: [  221.524392] CPU:    0
> Nov 18 15:44:31 tux6127 kernel: [  221.524393] EIP:    0060:[<c0126b5b>]    Not tainted VLI
> Nov 18 15:44:31 tux6127 kernel: [  221.524394] EFLAGS: 00010202   (2.6.15-rc1-mm2) 
> Nov 18 15:44:31 tux6127 kernel: [  221.524525] EIP is at ptrace_check_attach+0x24/0xc4



Christoph sent this patch earlier, which fixed same problem for me.


Thanks,
Badari



--=-uGyjG8Cw2tksbTA1C5pf
Content-Disposition: attachment; filename=ptrace-fix.patch
Content-Type: text/x-patch; name=ptrace-fix.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Looks like 2.6.15-rc1-mm1 has total crap in ptrace_get_task_struct
(and it looks like my fault because I sent out a wrong patch).

The patch below should fix it:

Index: linux-2.6/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/kernel/ptrace.c	2005-11-18 10:25:35.000000000 +0100
+++ linux-2.6/kernel/ptrace.c	2005-11-18 10:25:54.000000000 +0100
@@ -459,7 +459,7 @@
 	read_unlock(&tasklist_lock);
 	if (!child)
 		return ERR_PTR(-ESRCH);
-	return 0;
+	return child;
 }
 
 #ifndef __ARCH_SYS_PTRACE


--=-uGyjG8Cw2tksbTA1C5pf--

