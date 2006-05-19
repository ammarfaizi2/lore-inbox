Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWESKA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWESKA6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 06:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWESKA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 06:00:58 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:28358 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751326AbWESKA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 06:00:57 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Brice Goglin <brice@myri.com>
Subject: Re: [PATCH 3/4] myri10ge - Driver core
Date: Fri, 19 May 2006 12:00:46 +0200
User-Agent: KMail/1.9.1
Cc: netdev@vger.kernel.org, gallatin@myri.com, linux-kernel@vger.kernel.org
References: <20060517220218.GA13411@myri.com> <200605190355.11230.arnd@arndb.de> <446D2CA7.2070009@myri.com>
In-Reply-To: <446D2CA7.2070009@myri.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605191200.47132.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 May 2006 04:25, Brice Goglin wrote:
> dev_mc_upload() from net/core/dev_mcast.c does
> 
> spin_lock_bh(&dev->xmit_lock);
> __dev_mc_upload(dev);
> 
> which calls dev->set_multicast_list(), which is
> myri10ge_set_multicast_list()
> 
> which calls myri10ge_change_promisc
> 
> which calls myri10ge_send_cmd

Hmm, if that is the only path where you call it, it may be
helpful to change myri10ge_change_promisc to call a special
atomic version of myri10ge_send_cmd then, while all others
use the regular version, which you can then convert to
do msleep as well.

	Arnd <><
