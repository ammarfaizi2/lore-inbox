Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264171AbTKUAH6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 19:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264176AbTKUAH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 19:07:58 -0500
Received: from holomorphy.com ([199.26.172.102]:6577 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264171AbTKUAGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 19:06:48 -0500
Date: Thu, 20 Nov 2003 16:03:35 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: What keeps drivers/base/sys.c sysdev_show() from overrunning buffer?
Message-ID: <20031121000335.GP22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, mochel@osdl.org,
	linux-kernel@vger.kernel.org
References: <20031120155211.5cd2897a.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120155211.5cd2897a.pj@sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 03:52:11PM -0800, Paul Jackson wrote:
> The calls in drivers/base/sys.c to sysdev_show(), which seem to resolve
> to the routines node_read_cpumap() and node_read_meminfo() in node.c,
> do not take any buffer count (size).  They used to, by Patrick removed
> the count parameter in Jan 2003, from here and other such places.
> What's to keep the node_read_*() sprintf's from overrunning these
> buffers?
> I am developing some changes to the cpumask_t print routines, which
> include using snprintf() instead of sprintf(), and watching buffer
> limits.  These changes are motivated by the need to handle such things
> as 512 CPUs.
> I couldn't plug my new routine into read_cpumap() to display the
> node_dev->cpumap (a cpumask_t), for want of a buffer count.

There was some infrastructure erected for this at one point (seq_file);
I wonder why it's not using that. But yes, this needs to get taken
care of one way or another.


-- wli
