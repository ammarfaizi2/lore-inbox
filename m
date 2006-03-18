Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751722AbWCRBx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbWCRBx6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 20:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbWCRBx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 20:53:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24750 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751722AbWCRBx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 20:53:57 -0500
Date: Fri, 17 Mar 2006 17:50:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: rjw@sisk.pl, pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: -mm: PM=y, VT=n doesn't compile
Message-Id: <20060317175019.7c000847.akpm@osdl.org>
In-Reply-To: <20060317171814.GO3914@stusta.de>
References: <20060317171814.GO3914@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
>  swsusp-pm-refuse-to-suspend-devices-if-wrong-console-is-active.patch
>  causes the following compile error with CONFIG_PM=y, CONFIG_VT=n:
> 
>  <--  snip  -->
> 
>  ...
>    LD      .tmp_vmlinux1
>  drivers/built-in.o: In function `device_suspend': undefined reference to `fg_console'
>  drivers/built-in.o: In function `device_suspend': undefined reference to `vc_cons'
>  make: *** [.tmp_vmlinux1] Error 1

Right, thanks.  I'll drop that patch.

Guys, please don't go poking around in the vt subsystems's internal data
structures from within power management code.

Write a nice little helper function, put that in vt.c, give it a static
inline `return 0' stub in the header file, then call that.

That's Kernel Programming 101, no?
