Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWEPTyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWEPTyg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 15:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWEPTyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 15:54:36 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:23261 "EHLO
	BAYC1-PASMTP11.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1750888AbWEPTyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 15:54:36 -0400
Message-ID: <BAYC1-PASMTP11E93E051D25687C02443DB9A00@CEZ.ICE>
X-Originating-IP: [67.71.148.17]
X-Originating-Email: [johnmccuthan@sympatico.ca]
Subject: Re: [PATCH] fix race in inotify_release
From: John McCutchan <john@johnmccutchan.com>
Reply-To: john@johnmccutchan.com
To: Amy Griffis <amy.griffis@hp.com>
Cc: linux-kernel@vger.kernel.org, Robert Love <rlove@rlove.org>
In-Reply-To: <20060516193941.GA27045@zk3.dec.com>
References: <20060516193941.GA27045@zk3.dec.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 16 May 2006 15:54:40 -0400
Message-Id: <1147809280.2752.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-OriginalArrivalTime: 16 May 2006 19:59:18.0093 (UTC) FILETIME=[370B1FD0:01C67923]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-16 at 15:39 -0400, Amy Griffis wrote:
> While doing some inotify stress testing, I hit the following race.  In
> inotify_release(), it's possible for a watch to be removed from the
> lists in between dropping dev->mutex and taking inode->inotify_mutex.
> The reference we hold prevents the watch from being freed, but not
> from being removed.
> 
> Checking the dev's idr mapping will prevent a double list_del of the
> same watch.

Looks good. Thanks for the patch and stress testing inotify!


-- 
John McCutchan <john@johnmccutchan.com>
