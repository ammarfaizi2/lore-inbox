Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbUFCIuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUFCIuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 04:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUFCIuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 04:50:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30905 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261937AbUFCIuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 04:50:11 -0400
Date: Thu, 3 Jun 2004 10:50:03 +0200
From: Jens Axboe <axboe@suse.de>
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: submit_bh leaves interrupts on upon return
Message-ID: <20040603085002.GG28915@suse.de>
References: <40BE93DC.6040501@drdos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BE93DC.6040501@drdos.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02 2004, Jeff V. Merkey wrote:
> 
> Any reason why submit_bh should turn on interrupts after being called by 
> a process with ints off in 2.4.20?  I see it's possible to sleep during 
> elevatoring, but why does it need to leave interrupts on if the calling 
> state was with ints off.  

It's illegal to call it with interrupts off, so... __make_request()
doesn't save interrupt state, so you will always leave with interrupts
enabled.

-- 
Jens Axboe

