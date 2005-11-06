Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbVKFEdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbVKFEdI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 23:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVKFEdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 23:33:07 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:44229 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S932284AbVKFEdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 23:33:06 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, rjw@sisk.pl, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, mingo@elte.hu, linux@brodo.de,
       venkatesh.pallipadi@intel.com
Subject: Re: 2.6.14-git3: scheduling while atomic from cpufreq on Athlon64 
In-reply-to: Your message of "Sat, 05 Nov 2005 15:54:07 -0800."
             <20051105155407.A31099@unix-os.sc.intel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 06 Nov 2005 15:32:55 +1100
Message-ID: <26361.1131251575@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Nov 2005 15:54:07 -0800, 
Ashok Raj <ashok.raj@intel.com> wrote:
>Since when we already in the cpu notifier callbacks, cpucontrol is already
>held by the cpu_up() or the cpu_down() that caused the double lock.

Add the owning cpu id to the lock.  spin_trylock() first, if the lock
is already held then check if the current cpu owns the lock.  If it
does then continue, noting (in a local variable) that you do not need
to drop the lock on exit from this recursion level.

