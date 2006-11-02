Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWKBOh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWKBOh4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 09:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWKBOh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 09:37:56 -0500
Received: from brick.kernel.dk ([62.242.22.158]:35692 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750905AbWKBOhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 09:37:55 -0500
Date: Thu, 2 Nov 2006 15:39:45 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 3/8] cciss: change number of commands per controller
Message-ID: <20061102143945.GM13555@kernel.dk>
References: <20061101215640.GC29928@beardog.cca.cpqcorp.net> <20061102141149.GI13555@kernel.dk> <20061102143318.GB16430@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061102143318.GB16430@beardog.cca.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02 2006, Mike Miller (OS Dev) wrote:
> On Thu, Nov 02, 2006 at 03:11:50PM +0100, Jens Axboe wrote:
> > On Wed, Nov 01 2006, Mike Miller (OS Dev) wrote:
> > > +	{0x3211103C, "Smart Array E200i", &SA5_access, 120},
> > 
> > Is it 120, or 128? And how big is the allocated command array now, with
> > 512 commands?
> 
> The controller can handle up to 128, but I artificially limited it to 120
> for reasons I shouldn't discuss in public. :)

:-)

> Each command is 548 bytes w/o scatter gather chaining. So 548 * 512 = 280576
> bytes for the command list. We've tested using 1024 commands with several
> Smart Array controllers and have not encountered issues. The reason for the
> increase is performance. The busier you can keep the controller the better
> it works.

So this:

       hba[i]->cmd_pool = (CommandList_struct *)
            pci_alloc_consistent(hba[i]->pdev,
                    NR_CMDS * sizeof(CommandList_struct),
                    &(hba[i]->cmd_pool_dhandle));

is getting pretty huge then (it was already, actually).

-- 
Jens Axboe

