Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265578AbUAIDw3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 22:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265602AbUAIDw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 22:52:29 -0500
Received: from watson.far.bakerst.org ([209.167.125.194]:46211 "EHLO
	moran.bakerst.org") by vger.kernel.org with ESMTP id S265578AbUAIDw1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 22:52:27 -0500
Subject: solved it (at lest for me) "MASQUERADE: Route sent us somewhere
	else."
From: Neal Stephenson <neal@bakerst.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Very Little
Message-Id: <1073620346.17985.26.camel@moran.bakerst.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 08 Jan 2004 22:52:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I figured out my routing problems which were causing

MASQUERADE: Route sent us somewhere else.

messages from the kernel. I use iptables to masquerade and mangle
packets so with the advanced router features i can send it out
appropriate interfaces (i.e. web traffic out my residential ISP service
not my commercial ISP service). See the earlier thread on this for more
info (Subject 2.4.23 masquerading broken?). I got a useful reply from
Martin Josefsson who suggested that ipt_MASQUERADE could no longer find
the input-interface anymore. Upon further investigation and it seems all
the rules with iif or from in them no longer work (at least for me). So
rules like the following will cause the error in post 2.4.22 kernels.

ip rule add pri 420 from IP lookup TABLE

I now use exclusively rules of the form 

ip rule add pri 420 fwmark MARK table TABLE

and mark all packets needing special routing with mangling rules such as

iptables -t mangle -A PREROUTING -s IP -j MARK --set-mark MARK

this seems to prevent the problem. Don't know what changed in the
kernel.

		Neal

