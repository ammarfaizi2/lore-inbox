Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVC3JOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVC3JOe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 04:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVC3JOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 04:14:33 -0500
Received: from mx1.mail.ru ([194.67.23.121]:64109 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261822AbVC3JO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 04:14:26 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: 2.6.12-rc1-bk2+PREEMPT_BKL: Oops at serio_interrupt
Date: Wed, 30 Mar 2005 13:14:39 +0400
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <200503282126.55366.adobriyan@mail.ru> <200503292349.55319.adobriyan@mail.ru> <200503300130.12736.dtor_core@ameritech.net>
In-Reply-To: <200503300130.12736.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503301314.39575.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 March 2005 10:30, Dmitry Torokhov wrote:
> On Tuesday 29 March 2005 14:49, Alexey Dobriyan wrote:
> > According to vmlinux, c0202947 is at:
> > 
> > c020293e <serport_ldisc_write_wakeup>:
> 
> Could you please try this one instead? Thanks!

Still dies in serport_ldisc_write_wakeup (doesn't matter how to trigger)
via:

Unable to handle kernel NULL pointer dereference at virtual address 00000068
EIP: c020294f
	tty_wakeup
	uart_close
	wait_for_completion
	release_dev

If you want me to be more specific, wait until I figure out how to print
only parts of oops (to fit them on console).
============================================================================
c0202930 <serport_ldisc_write_wakeup>:
c0202930:       push   %esi
c0202931:       push   %ebx
c0202932:       mov    0x978(%eax),%ebx
c0202938:       pushf
c0202939:       pop    %esi
c020293a:       cli
c020293b:       mov    $0x1,%eax
c0202940:       call   c010ecaf <add_preempt_count>
c0202945:       mov    0x14(%ebx),%eax
c0202948:       test   $0x4,%al
c020294a:       jne    c0202956 <serport_ldisc_write_wakeup+0x26>
c020294c:       mov    0xc(%ebx),%eax
c020294f: ==>>  mov    0x68(%eax),%edx	<<==
c0202952:       test   %edx,%edx
c0202954:       jne    c0202973 <serport_ldisc_write_wakeup+0x43>
c0202956:       push   %esi
c0202957:       popf
c0202958:       mov    $0x1,%eax
c020295d:       call   c010ece1 <sub_preempt_count>
c0202962:       mov    $0xfffff000,%eax
c0202967:       and    %esp,%eax
c0202969:       mov    0x8(%eax),%eax
c020296c:       test   $0x8,%al
c020296e:       jne    c0202984 <serport_ldisc_write_wakeup+0x54>
c0202970:       pop    %ebx
c0202971:       pop    %esi
c0202972:       ret
c0202973:       mov    0x10(%edx),%edx
c0202976:       test   %edx,%edx
c0202978:       je     c0202956 <serport_ldisc_write_wakeup+0x26>
c020297a:       lea    0x0(%esi),%esi
c0202980:       call   *%edx
c0202982:       jmp    c0202956 <serport_ldisc_write_wakeup+0x26>
c0202984:       pop    %ebx
c0202985:       pop    %esi
c0202986:       jmp    c029ad16 <preempt_schedule>
