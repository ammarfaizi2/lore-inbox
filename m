Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbVJYXnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbVJYXnT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 19:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbVJYXnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 19:43:19 -0400
Received: from mx1.suse.de ([195.135.220.2]:17350 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932486AbVJYXnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 19:43:18 -0400
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Notifier chains are unsafe
References: <Pine.LNX.4.44L0.0510241634410.4448-100000@iolanthe.rowland.org>
From: Andi Kleen <ak@suse.de>
Date: 26 Oct 2005 01:43:16 +0200
In-Reply-To: <Pine.LNX.4.44L0.0510241634410.4448-100000@iolanthe.rowland.org>
Message-ID: <p733bmp40yz.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> Has anyone been bothered by the fact that notifier chains are not safe 
> with regard to registration and unregistration while the chain is in use?
> The notifier_chain_register and notifier_chain_unregister routines have 
> writelock protections, but the corresponding readlock is never taken!

If you add locks to the reader make sure it is only taken
if the list is non empty. Otherwise you will add unacceptable
overhead to some fast paths.
 
Better would be likely to use RCU.

-Andi
