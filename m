Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbSJYWVA>; Fri, 25 Oct 2002 18:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261659AbSJYWUx>; Fri, 25 Oct 2002 18:20:53 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:59839 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261660AbSJYWQd>; Fri, 25 Oct 2002 18:16:33 -0400
Date: Fri, 25 Oct 2002 17:22:46 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: kernelnewbie@gate.debonne.net
cc: linux-kernel@vger.kernel.org
Subject: Re: Passing info from the top-half ISR to the bottom-half
In-Reply-To: <Pine.LNX.4.33.0210241827460.24173-100000@gate.debonne.net>
Message-ID: <Pine.LNX.4.44.0210251717220.6574-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2002 kernelnewbie@gate.debonne.net wrote:

> My ISR is split into top-half and bottom-half processing. The bottom-half
> is implemented as a tasklet (I'm using Kernel 2.4). The top-half knows
> which physical device (minor number) caused the interrupt and that info
> has to be passed to the tasklet somehow.
> 
> The DECLARE_TASKLET macro provides an unsigned long data argument, but it
> appears that that argument must be constant. Rubini's book says it's fine
> to pass a pointer via this data argument, and I'd like to pass the pointer
> to my device control block, but since the argument must be a constant, the
> best I can do is pass a pointer to a global which points to my DCB. But
> this won't work because another device's interrupt will overwrite it.
> 
> Do I have to make a separate DECLARE_TASKLET for each physical device like
> the following:

I think the answer is yes, you want to have a tasklet per device, but not 
like what was following ;)

You should just add the struct tasklet_struct into your per-device private 
data (DCB - driver control block? sounds like Windows to me...), and have
it point back to it. Should work just fine, much cleaner than a number of 
global tasklet declarations.

--Kai


