Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbVADHos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVADHos (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 02:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbVADHos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 02:44:48 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54675 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262207AbVADHoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 02:44:30 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 boot loader IDs
References: <41D31696.8050701@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Jan 2005 00:43:22 -0700
In-Reply-To: <41D31696.8050701@zytor.com>
Message-ID: <m1vfadr65h.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> This patch adds some i386 boot loader IDs that were used but never officially
> recorded as assigned.  This makes them nice and official.
> 
>  	Please contact <hpa@zytor.com> if you need a bootloader ID
>  	value assigned.

I suspect /sbin/kexec could use one.  But I don't have the faintest
what you could do with the information after the kernel came up.

I don't think enhancing the bootloader numeric parameter is the
right way to go.  Currently the value is a single byte with the low
nibble reserved for version number information.  With the
values already assigned we have 7 left.  

If we assign a new value each for the bootloaders I know of that don't
yet have values assigned: pxelinux, isolinux, filo, /sbin/kexec,
redboot the pool of numbers is nearly exhausted.  With the addition of
bootloaders I can't recall or have not been written yet we will
quickly exhaust the pool of numbers.

Even if using this mechanism is needed for supporting existing
bootloaders I suggest it be deprecated in favor of a kernel command
line option.  A command line option would be easier to maintain
being string based.  It would be portable to architectures besides
x86.  And it requires no additional code to implement, as you
can already read /proc/cmdline.

Eric
