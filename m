Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262769AbVBCKAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbVBCKAJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 05:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbVBCKAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 05:00:09 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28546 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262778AbVBCJ76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 04:59:58 -0500
To: Itsuro Oda <oda@valinux.co.jp>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: kdump on non-boot cpu
References: <20050203140438.18E1.ODA@valinux.co.jp>
	<1107412952.11609.174.camel@2fwv946.in.ibm.com>
	<20050203171700.18E7.ODA@valinux.co.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Feb 2005 02:58:02 -0700
In-Reply-To: <20050203171700.18E7.ODA@valinux.co.jp>
Message-ID: <m1pszi6k45.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Itsuro Oda <oda@valinux.co.jp> writes:

> Hi,
> 
> This is not for kdump but an experience of our project(mkdump).
> The dump kernel(not SMP config) boot hangs if machine_kexec()
> excutes on non-boot CPU on x86_64 platform.

?? x86_64 is Opteron cpu, amd64, Intel cpu?
Are the kernels running in 32bit or 64bit mode. I'm guessing
SMP Opterons running in 32bit mode.

Anyway one thing I want to do is actually drop the apic shutdown
code altogether in this code path.  I threw it in there to
ease the transition from the old code base to the new, but
if that code is causing issues....  So this is probably a good time
to start testing that.

> We don't found why. (Please let me know if you know why.)
> but fix that the boot-cpu excutes machine_kexec() in the nmi handler. 
> (It becomes OK after that)

My best hunch is that your UP kernel is not getting interrupts.
Any chance on getting a serial console boot log?  

I suspect it can be made to work if you compile your UP
kernel with IOAPIC support.  I do know the table parsers
no longer complain about the configuration.

Eric
