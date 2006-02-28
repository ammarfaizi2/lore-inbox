Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWB1TkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWB1TkK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWB1TkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:40:10 -0500
Received: from kanga.kvack.org ([66.96.29.28]:45992 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932461AbWB1TkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:40:09 -0500
Date: Tue, 28 Feb 2006 14:34:59 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
Message-ID: <20060228193459.GF24306@kvack.org>
References: <1140841250.2587.33.camel@localhost.localdomain> <20060225142814.GB17844@kvack.org> <1140887517.9852.4.camel@localhost.localdomain> <20060225174134.GA18291@kvack.org> <1141149009.24103.8.camel@camp4.serpentine.com> <20060228175838.GD24306@kvack.org> <1141150814.24103.37.camel@camp4.serpentine.com> <20060228190354.GE24306@kvack.org> <1141154424.20227.11.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141154424.20227.11.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 11:20:24AM -0800, Bryan O'Sullivan wrote:
> So if we just use wmb(), we incur a 16-cycle penalty on every packet we
> send.  This has a deleterious and measurable effect on performance.

sfence doesn't guarantee that the write will be flushed, especially if 
the chipset gets involved.  The only way to do that is the same way any 
pci write can be flushed, which is to read from a register on the device 
in question.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
