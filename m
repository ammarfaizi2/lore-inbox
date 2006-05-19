Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWESLJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWESLJo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 07:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWESLJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 07:09:44 -0400
Received: from cantor.suse.de ([195.135.220.2]:32733 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932272AbWESLJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 07:09:43 -0400
From: Andi Kleen <ak@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/4] myri10ge - Driver core
Date: Fri, 19 May 2006 13:09:30 +0200
User-Agent: KMail/1.9.1
Cc: Brice Goglin <brice@myri.com>, netdev@vger.kernel.org, gallatin@myri.com,
       linux-kernel@vger.kernel.org
References: <20060517220218.GA13411@myri.com> <446D2CA7.2070009@myri.com> <200605191200.47132.arnd@arndb.de>
In-Reply-To: <200605191200.47132.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605191309.30992.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 May 2006 12:00, Arnd Bergmann wrote:
> On Friday 19 May 2006 04:25, Brice Goglin wrote:
> > dev_mc_upload() from net/core/dev_mcast.c does
> > 
> > spin_lock_bh(&dev->xmit_lock);
> > __dev_mc_upload(dev);
> > 
> > which calls dev->set_multicast_list(), which is
> > myri10ge_set_multicast_list()
> > 
> > which calls myri10ge_change_promisc
> > 
> > which calls myri10ge_send_cmd
> 
> Hmm, if that is the only path where you call it, it may be
> helpful to change myri10ge_change_promisc to call a special
> atomic version of myri10ge_send_cmd then, while all others
> use the regular version, which you can then convert to
> do msleep as well.

Or just drop the xmit lock while you do that. As long as you
handle races with ->start_xmit yourself it's ok

-Andi
