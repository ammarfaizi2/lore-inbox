Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266765AbSK1WdK>; Thu, 28 Nov 2002 17:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266792AbSK1WdK>; Thu, 28 Nov 2002 17:33:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22028 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266765AbSK1WdK>; Thu, 28 Nov 2002 17:33:10 -0500
Date: Thu, 28 Nov 2002 22:40:28 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Georg Nikodym <georgn@somanetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: v2.4.19-rmk4 slab.c: /proc/slabinfo uses broken instead of slab labels
Message-ID: <20021128224028.F27234@flint.arm.linux.org.uk>
Mail-Followup-To: Manfred Spraul <manfred@colorfullife.com>,
	Georg Nikodym <georgn@somanetworks.com>,
	linux-kernel@vger.kernel.org
References: <3DE699EC.9060600@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DE699EC.9060600@colorfullife.com>; from manfred@colorfullife.com on Thu, Nov 28, 2002 at 11:34:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2002 at 11:34:20PM +0100, Manfred Spraul wrote:
> On i386, it's possible to skip set_fs() and use __get_user() - but 
> that's i386 specific. For example the i386 oops code uses that.

That isn't actually an x86 specific feature - it is a requirement across
all architectures that get_user() and friends can access kernel areas
after set_fs(get_ds())

That's how things like sys_execve() can read the binary headers, etc.
See linux/fs/exec.c:kernel_read() for one such example.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

