Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbTJNMTL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 08:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTJNMTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 08:19:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38663 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262384AbTJNMTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 08:19:01 -0400
Date: Tue, 14 Oct 2003 13:18:56 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: mem=16MB laptop testing
Message-ID: <20031014131856.A17629@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
	linux-kernel@vger.kernel.org
References: <20031014105514.GH765@holomorphy.com> <20031014045614.22ea9c4b.akpm@osdl.org> <20031014125848.A17145@flint.arm.linux.org.uk> <20031014051031.1d2b5f23.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031014051031.1d2b5f23.akpm@osdl.org>; from akpm@osdl.org on Tue, Oct 14, 2003 at 05:10:31AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 05:10:31AM -0700, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > On Tue, Oct 14, 2003 at 04:56:14AM -0700, Andrew Morton wrote:
> > > I guess not mounting /sys doesn't help here.  It would be nice.  Maybe with
> > > a CONFIG_I_WILL_NEVER_MOUNT_SYSFS we could avoid all those allocations.
> > 
> > I believe sysfs is required for mounting the root filesystem - see
> > name_to_dev_t in init/do_mounts.c.
> 
> OK.  But it looks like if /sys is empty and you provide "root=03:02" then
> things will still work.  It's a matter of trying it...

Uhh?

dev_t name_to_dev_t(char *name)
{
        dev_t res = 0;

        sys_mkdir("/sys", 0700);
        if (sys_mount("sysfs", "/sys", "sysfs", 0, NULL) < 0)
                goto out;

	...

out:
        sys_rmdir("/sys");
        return res;
}

If sysfs can't be mounted, then it looks like we can't even decode a
numeric major:minor root device specification.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
