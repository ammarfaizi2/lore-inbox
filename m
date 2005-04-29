Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbVD2MsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbVD2MsI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 08:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVD2MsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 08:48:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:36051 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262534AbVD2MsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 08:48:03 -0400
Date: Fri, 29 Apr 2005 05:47:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3 mmap lack of consistency among runs
Message-Id: <20050429054726.093a88cc.akpm@osdl.org>
In-Reply-To: <0561FRW12@server5.heliogroup.fr>
References: <0561FRW12@server5.heliogroup.fr>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Tonneau <hubert.tonneau@fullpliant.org> wrote:
>
> As a way to freeze then restart processes,
> the first shot of the process calls 'mmap' with NULL as 'start',
> then restarts of the process will call 'mmap' with the value received at the
> first shot, and expect to be assigned the requested area.
> 
> This used to work perfectly with 2.6.11 and all previous kernels (unless some
> shared libraries have been upgraded in the mean time),
> but with 2.6.12-rc3 (I have not tested rc1 and rc2) it fails half time.
> 
> I can solve the problem through specifying a 'start' value at the first shot,
> but then I will get a more serious problem on the long run because the
> application would then have to be awared of the general layout of the address
> space enforced by the kernel and so could be disturbed by any change.

Maybe you're being bitten by the address space randomisation.

Try
	echo 0 > /proc/sys/kernel/randomize_va_space
