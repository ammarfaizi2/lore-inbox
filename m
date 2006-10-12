Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWJLNJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWJLNJE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 09:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWJLNJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 09:09:04 -0400
Received: from brick.kernel.dk ([62.242.22.158]:36423 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751388AbWJLNJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 09:09:02 -0400
Date: Thu, 12 Oct 2006 15:09:07 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Vasily Tarasov <vtaras@openvz.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       OpenVZ Developers List <devel@openvz.org>
Subject: Re: [PATCH] block layer: ioprio_best function fix
Message-ID: <20061012130907.GZ6515@kernel.dk>
References: <200610121213.k9CCDbPi004548@vass.7ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610121213.k9CCDbPi004548@vass.7ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12 2006, Vasily Tarasov wrote:
> Currently ioprio_best function first checks wethere aioprio or bioprio equals
> IOPRIO_CLASS_NONE (ioprio_valid() macros does that) and if it is so it returns
> bioprio/aioprio appropriately. Thus the next four lines, that set aclass/bclass
> to IOPRIO_CLASS_BE, if aclass/bclass == IOPRIO_CLASS_NONE, are never executed.
> 
> The second problem: if aioprio from class IOPRIO_CLASS_NONE and bioprio from
> class IOPRIO_CLASS_IDLE are passed to ioprio_best function, it will return
> IOPRIO_CLASS_IDLE. It means that during __make_request we can merge two
> requests and set the priority of merged request to IDLE, while one of
> the initial requests originates from a process with NONE (default) priority.
> So we can get a situation when a process with default ioprio will experience
> IO starvation, while there is no process from real-time class in the system.
> 
> Just removing ioprio_valid check should correct situation.

Analysis looks correct, thanks.

-- 
Jens Axboe

