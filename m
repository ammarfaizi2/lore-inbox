Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319254AbSIFQPL>; Fri, 6 Sep 2002 12:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319257AbSIFQPL>; Fri, 6 Sep 2002 12:15:11 -0400
Received: from niwot.scd.ucar.edu ([128.117.8.223]:22478 "EHLO
	niwot.scd.ucar.edu") by vger.kernel.org with ESMTP
	id <S319254AbSIFQPK>; Fri, 6 Sep 2002 12:15:10 -0400
Date: Fri, 6 Sep 2002 10:19:44 -0600
From: Craig Ruff <cruff@ucar.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: ide drive dying?
Message-ID: <20020906101944.A5506@bells.scd.ucar.edu>
References: <Pine.LNX.4.33.0209061123550.30387-100000@router.windsormachine.com> <Pine.LNX.3.95.1020906113826.1557A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.3.95.1020906113826.1557A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Fri, Sep 06, 2002 at 11:44:52AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2002 at 11:44:52AM -0400, Richard B. Johnson wrote:
>              IBM DeathStar 75gxp.
> 
> Well put. Also, don't turn off this drive --ever. If possible, back-up
> to something on a network, not to anything on the IDE bus.

I had one of these drives fail recently with the dread "clicking of death"
sounds (while it was retrying reads).  What I discovered, while backing up
the disk, is that continuing sequential reads past the bad sectors without
and intervening operation would eventually cause the drive to get into a
messed up state where it erroneously reported the following good sectors
as bad.

My strategy to recover the good data was to read sequentially until I 
got an error, then explicitly seek to the next good sector and continue
from there.  This enabled me to copy the good data.

