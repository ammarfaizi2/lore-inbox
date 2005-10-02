Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbVJBF2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbVJBF2Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 01:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbVJBF2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 01:28:25 -0400
Received: from mail.collax.com ([213.164.67.137]:28815 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750973AbVJBF2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 01:28:24 -0400
Message-ID: <433F6FF3.1040706@trash.net>
Date: Sun, 02 Oct 2005 07:28:19 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
CC: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: 2.6.13-rc2+ - problem with DHCP
References: <433EBBEC.4050203@gorzow.mm.pl> <433ECE42.2070400@trash.net> <433F0228.6000304@gorzow.mm.pl>
In-Reply-To: <433F0228.6000304@gorzow.mm.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Radoslaw Szkodzinski wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Patrick McHardy wrote:
> |
> | Are you sure? The patch was supposed to fix problems with DHCP clients
> | using regular UDP sockets for sending DHCP requests. Which client are
> | you using?
> |
> 
> udhcpcd, version 0.9.9-pre (Gentoo ebuild
> net-misc/udhcp-0.9.9_pre20041216-r1, no crazy optimisations, stock init
> script, IP release disabled)

I can't reproduce the problem, it reliably works for me using pump,
dhclient or udhcpc. One thing I've noticed is that udhcpc 0.98
doesn't set the interface up itself and fails if it is down. Please
make sure that it is up in your tests.

> 2.6.13, 2.6.14-rc1 (up to the patch) both work fine.
> 2.6.14-rc2 and 2.6.14-rc3 do not. (they can't discover IP address)
> The window is between that commit and rc2.
> (about 180 changesets)
> 
> I only suspect that patch, it could be something else but I highly doubt
> it. I'll check the current kernel with the patch backed out when I have
> to restart.

Thanks. You mentioned you're setting up your ruleset after DHCP, which
means the patch can't be responsible because the codepath is never
taken for DHCP queries, so you probably need to do a binary search
over the remaining 180 changesets.
