Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUCIBYd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 20:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbUCIBYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 20:24:33 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:9926 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261425AbUCIBYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 20:24:03 -0500
Date: Mon, 8 Mar 2004 17:22:35 -0800 (PST)
From: Sridhar Samudrala <sri@us.ibm.com>
X-X-Sender: sridhar@localhost.localdomain
To: kaos@ocs.com.au
cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Cleaner way to conditionally disallow a CONFIG option as static
Message-ID: <Pine.LNX.4.58.0403081659170.1656@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCTP is allowed to be static only when IPV6 is also configured as static or
not enabled. If IPV6 is configured as a module, SCTP also has to be a module.
This is done right now in the following hackish ways in 2.6 and 2.4 using an
additional config option(CONFIG_IPV6_SCTP__).

In 2.6, net/sctp/Kconfig

config IPV6_SCTP__
	tristate
	default y if IPV6=n
	default IPV6 if IPV6

config IP_SCTP
	tristate "The SCTP Protocol (EXPERIMENTAL)"
	depends on IPV6_SCTP__
--------------------------------------------------------
In 2.4, net/sctp/Config.in

if [ "$CONFIG_IPV6" != "n" ]; then
   define_bool CONFIG_IPV6_SCTP__ $CONFIG_IPV6
else
   define_bool CONFIG_IPV6_SCTP__ y
fi

dep_tristate '  The SCTP Protocol (EXPERIMENTAL)' CONFIG_IP_SCTP $CONFIG_IPV6_SCTP__
--------------------------------------------------------

Is there a much simpler and cleaner way to accomplish this in 2.6 and 2.4
config files?

Thanks
Sridhar
