Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965216AbVIVCnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965216AbVIVCnx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 22:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965217AbVIVCnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 22:43:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35030 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965216AbVIVCns
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 22:43:48 -0400
Date: Thu, 22 Sep 2005 03:43:39 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Florin Malita <fmalita@gmail.com>,
       linux-kernel@vger.kernel.org, ctindel@users.sourceforge.net,
       fubar@us.ibm.com, "David S. Miller" <davem@davemloft.net>,
       netdev@vger.kernel.org
Subject: Re: [PATCH] bond_main.c: fix device deregistration in init exception path
Message-ID: <20050922024339.GD7992@ftp.linux.org.uk>
References: <432D0612.7070408@gmail.com> <20050917233224.2d4b3652.akpm@osdl.org> <43321922.70707@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43321922.70707@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 10:38:26PM -0400, Jeff Garzik wrote:
> >+	rtnl_unlock();
> >+	rtnl_lock();
> >+
> 
> 
> Don't we want a schedule() or schedule_timeout(1) in between?

No.  rtnl_unlock() does the needed calls directly.
