Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbUBRGm0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 01:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbUBRGm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 01:42:26 -0500
Received: from test.estpak.ee ([194.126.115.47]:64743 "EHLO arena.estpak.ee")
	by vger.kernel.org with ESMTP id S261807AbUBRGmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 01:42:25 -0500
From: Hasso Tepper <hasso@estpak.ee>
To: davids@webmaster.com
Subject: Re: raw sockets and blocking
Date: Wed, 18 Feb 2004 08:42:18 +0200
User-Agent: KMail/1.6.1
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKIEMGKHAA.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKIEMGKHAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Disposition: inline
Organization: Elion Enterprises Ltd.
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402180842.19288.hasso@estpak.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
> > we havnt yet tested if it becomes writeable again if we put cable
> > back in, however if we detect absence of IFF_RUNNING and hence
> > manually avoid constructing packets to be sent via link-down
> > interfaces, we avoid this problem. However, this leaves us with a
> > race.
>
> 	I'm not sure I understand what the problem is. If the network
> cable is disconnected, you couldn't usefully send anything if the
> socket was ready anyway.

One raw socket is used to send packets to several interfaces. If only 
one of them is down, socket will be blocked as well.

Related problem is that we have no way to detect if vlan interface 
goes down. Wouldn't be correct behavior to remove IFF_RUNNING from 
all vlan interfaces bound to ethernet interface if this ethernet 
interface goes down? There might be similar problems with other 
network interfaces.

-- 
Hasso Tepper
Elion Enterprises Ltd.
WAN administrator
