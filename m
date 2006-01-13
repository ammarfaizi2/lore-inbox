Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423019AbWAMWVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423019AbWAMWVH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423020AbWAMWVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:21:07 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:529 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1423019AbWAMWVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:21:04 -0500
Date: Fri, 13 Jan 2006 17:20:54 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: wireless: recap of current issues (compatibility)
Message-ID: <20060113222054.GK16166@tuxdriver.com>
Mail-Followup-To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com> <20060113213126.GF16166@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113213126.GF16166@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compatibility
=============

The netlink configuration mechanism needs compatibility code to
translate wireless extension ioctls into netlink transactions.

We need to be an 802.11 stack (i.e. drivers need to handle 802.11
frames).  Ethernet emulation is bound to paint us into a corner
eventually (if it hasn't already).

We need an ethernet<->802.11 translational bridging interface for
compatibility, and to enable 802.1 bridging with ethernet.  This could
be a configuration setting for a wlan interface.  It might be limited
to wlan interfaces in station (or WDS) mode?

802.11 framing may break older protocols (e.g. DECnet).  I don't
see this as a big problem, as I imagine such installations aren't
rolling-out lots of WiFi...if I'm wrong, will the translational
bridging code resolve this issue?

Should a default wlan device be created at WiPHY init?  Should it
enable translational bridging?  I'm inclined against this, but is it
worthwhile for compatibility?  Could/should this be a configuration
option for the stack?

How about if WiPHY initialization triggered a netlink broadcast?
Then a daemon could monitor those broadcasts and create whatever wlan
devices (ethernet emulation, rfmon, none at all) that the daemon was
configured to create.  How would this effect modprobe behaviour?
-- 
John W. Linville
linville@tuxdriver.com
