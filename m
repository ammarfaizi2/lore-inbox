Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbVLAQli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbVLAQli (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 11:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbVLAQli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 11:41:38 -0500
Received: from gold.veritas.com ([143.127.12.110]:52888 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932327AbVLAQlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 11:41:37 -0500
Date: Thu, 1 Dec 2005 16:41:15 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Christopher Friesen <cfriesen@nortel.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: discrepency between "df" and "du" on tmpfs filesystem?
In-Reply-To: <438F179E.5040402@nortel.com>
Message-ID: <Pine.LNX.4.61.0512011634370.26131@goblin.wat.veritas.com>
References: <438F179E.5040402@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 01 Dec 2005 16:41:09.0260 (UTC) FILETIME=[082CACC0:01C5F696]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2005, Christopher Friesen wrote:
> 
> Someone noticed this on one of our machines.  The rootfs is a 256MB tmpfs
> filesystem.  Depending on how you check the size, you get two different
> answers.
> 
> root@10.41.50.66:/root> df -kl
> rootfs                  262144    255684      6460  98% /
> 
> root@10.41.50.66:/root> du -sxk /
> 204672  /
> 
> Anyone know what's going on?

df tells you what the filesystem says is in use or free, via statfs.
du goes looking at the contents of the filesystem, totalling stats.
Any files unlinked but held open will be counted by df but not by du.
There might also be a discrepancy over indirect blocks, I'm not sure.

Hugh
