Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWKBOdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWKBOdW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 09:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWKBOdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 09:33:22 -0500
Received: from palrel10.hp.com ([156.153.255.245]:34785 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1750862AbWKBOdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 09:33:21 -0500
Date: Thu, 2 Nov 2006 08:33:18 -0600
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 3/8] cciss: change number of commands per controller
Message-ID: <20061102143318.GB16430@beardog.cca.cpqcorp.net>
References: <20061101215640.GC29928@beardog.cca.cpqcorp.net> <20061102141149.GI13555@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061102141149.GI13555@kernel.dk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 03:11:50PM +0100, Jens Axboe wrote:
> On Wed, Nov 01 2006, Mike Miller (OS Dev) wrote:
> > +	{0x3211103C, "Smart Array E200i", &SA5_access, 120},
> 
> Is it 120, or 128? And how big is the allocated command array now, with
> 512 commands?

The controller can handle up to 128, but I artificially limited it to 120
for reasons I shouldn't discuss in public. :)

Each command is 548 bytes w/o scatter gather chaining. So 548 * 512 = 280576
bytes for the command list. We've tested using 1024 commands with several
Smart Array controllers and have not encountered issues. The reason for the
increase is performance. The busier you can keep the controller the better
it works.

mikem
