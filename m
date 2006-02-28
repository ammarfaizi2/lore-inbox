Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWB1R7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWB1R7n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 12:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWB1R7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 12:59:43 -0500
Received: from detroit.securenet-server.net ([209.51.153.26]:36004 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S932314AbWB1R7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 12:59:43 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
Date: Tue, 28 Feb 2006 09:59:38 -0800
User-Agent: KMail/1.9.1
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <1140841250.2587.33.camel@localhost.localdomain> <200602280944.32210.jbarnes@virtuousgeek.org> <1141149126.24103.11.camel@camp4.serpentine.com>
In-Reply-To: <1141149126.24103.11.camel@camp4.serpentine.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602280959.38986.jbarnes@virtuousgeek.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - detroit.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - virtuousgeek.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 28, 2006 9:52 am, Bryan O'Sullivan wrote:
> >   (In particular I wanted this for the sysfs PCI interface.
> > Userspace apps can map PCI resources there and it would be nice if
> > they could map them with WC semantics if requested.)
>
> They already sort of can.  It just happens that most arches ignore the
> WC parameters.

Only on a per-driver basis though at this point, right?  The sysfs code 
is generic across architectures and exports PCI resources independently 
from the driver, so it needs some way of letting the user communicate 
that they want WC behavior.

> > I don't think it addresses the flushing issue you seem to be
> > concerned about though.
>
> Yes, I think I could have made my original wording a bit clearer.  I
> don't care if writes have hit the device, merely that they do so in an
> order that I control.

Ah, ok.  In that case maybe mmiowb *is* what you want.  Or at the very 
least mmiowcb :).

Jesse
