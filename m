Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130073AbRBWBjm>; Thu, 22 Feb 2001 20:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130523AbRBWBjc>; Thu, 22 Feb 2001 20:39:32 -0500
Received: from pizda.ninka.net ([216.101.162.242]:20608 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130073AbRBWBjT>;
	Thu, 22 Feb 2001 20:39:19 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14997.48852.42724.728360@pizda.ninka.net>
Date: Thu, 22 Feb 2001 17:37:24 -0800 (PST)
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ipv4: 2.4.2: unused static variables
In-Reply-To: <200102221358.f1MDwIH30430@flint.arm.linux.org.uk>
In-Reply-To: <200102221358.f1MDwIH30430@flint.arm.linux.org.uk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Russell King writes:
 > With CONFIG_SYSCTL=n, I get the following warnings:
 > 
 > sysctl_net_ipv4.c:50: warning: `tcp_retr1_max' defined but not used
 > sysctl_net_ipv4.c:52: warning: `ip_local_port_range_min' defined but not used
 > sysctl_net_ipv4.c:53: warning: `ip_local_port_range_max' defined but not used
 > 
 > These are defined static in sysctl_net_ipv4.c, and appear to only be
 > exported via procfs.  In other words, you can set them to whatever you
 > like and the IPv4 stack couldn't care less.
 > 
 > Why do we have them?  If they're not used, can we either eliminate them,
 > or else move their definition within the '#ifdef CONFIG_SYSCTL' to
 > eliminate the warning?

They aren't set to anything because they are not sysctl
"values", they are sysctl "limits".  Ie. they tell the sysctl
layer what legal range the user's setting of a particular sysctl
must reside in.

The fix is to enclose these things in CONFIG_SYSCTL, which I have
done in my tree, thanks for bringing this to my attention.

Later,
David S. Miller
davem@redhat.com
