Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268236AbUIWDtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268236AbUIWDtn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 23:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268240AbUIWDtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 23:49:43 -0400
Received: from host50.200-117-131.telecom.net.ar ([200.117.131.50]:17375 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S268236AbUIWDtV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 23:49:21 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: FIXED?? (Is anyone using vmware 4.5 with 2.6.9-rc2-mm
Date: Thu, 23 Sep 2004 00:49:10 -0300
User-Agent: KMail/1.7
Cc: Kyle Schlansker <kylesch@gmail.com>, linux-kernel@vger.kernel.org
References: <4506E4E6490@vcnet.vc.cvut.cz> <200409222236.26323.norberto+linux-kernel@bensa.ath.cx> <19102930-0D04-11D9-B9FD-000D9352858E@linuxmail.org>
In-Reply-To: <19102930-0D04-11D9-B9FD-000D9352858E@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409230049.10668.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:
> > I'll try a plain /tmp directory, but I'd like to know why I can't use
> > tmpfs
> > anymore with kernels >=2.6.9-rc2-mm1.
>
> That's a question that requires far more knowledge than I have.
> Maybe someone here... Andrew?

I think I fixed.

It's not a problem of tmpfs. It's a permissions issue.

This:
tmpfs   /tmp   tmpfs     size=256m,noexec,nosuid,nodev      0 0

...gives the "can't allocate memory" message.

Doing:
# mount -o remount,exec /tmp
# /etc/init/vmware restart

Gives a working vmware (I've tried 2.6.9-rc2-mm1-VP-S2)

# mount | grep \ /tmp
tmpfs on /tmp type tmpfs (rw,nosuid,nodev,size=256m)

Now, why the hell does vmware want exec permission on /tmp, only vmware devs 
know :(


Thanks everyone,
Norberto
