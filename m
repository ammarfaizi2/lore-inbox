Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbVDMDEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbVDMDEF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 23:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVDMC42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 22:56:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3817 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262656AbVDMCxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 22:53:03 -0400
Date: Wed, 13 Apr 2005 03:53:00 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/pcmcia/nmclan_cs.c: fix a check after use
Message-ID: <20050413025300.GR8859@parcelfarce.linux.theplanet.co.uk>
References: <20050413021734.GQ3631@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413021734.GQ3631@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 04:17:34AM +0200, Adrian Bunk wrote:
> This patch fixes a check after use found by the Coverity checker.
 
Again, check is a pure BS.  Argument passed to this sucker comes from
->Instance of the same struct that had ->Handler equal to mace_interrupt().
That would be
    link->irq.Handler = &mace_interrupt;
    link->irq.Instance = dev;
in nmclan_attach().  Nothing ever modifies that beast afterwards and dev
sure as hell can't be NULL in nmclan_attach() (explict check and a bunch
of dereferencings prior to that point).

Adrian, could you please _read_ the code you are modifying?
