Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261209AbRELJMH>; Sat, 12 May 2001 05:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261210AbRELJL6>; Sat, 12 May 2001 05:11:58 -0400
Received: from ns.suse.de ([213.95.15.193]:58126 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S261209AbRELJLq>;
	Sat, 12 May 2001 05:11:46 -0400
Date: Sat, 12 May 2001 11:11:23 +0200
From: Andi Kleen <ak@suse.de>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ENOIOCTLCMD?
Message-ID: <20010512111123.A27451@gruyere.muc.suse.de>
In-Reply-To: <p05100302b7226d91e632@[207.213.214.37]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <p05100302b7226d91e632@[207.213.214.37]>; from jlundell@pobox.com on Fri, May 11, 2001 at 10:01:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 10:01:50PM -0700, Jonathan Lundell wrote:
> Can somebody explain the use of ENOIOCTLCMD? There are order of 170 
> uses in the kernel, but I don't see any guidelines for that use (nor 
> what prevents it from being seen by user programs).

The idea with ENOIOCTLCMD is that when you have multiple subsystem 
callbacks (e.g. to low level drivers) the higher levels can pass the ioctls
down and they return ENOIOCTLCMD when they don't know the ioctl number,
so other subsystems can be tried.
This is nicer than using EINVAL, because EINVAL is a terminal condition.
The higher layer should always convert it into EINVAL if there is not
another callback to call, but if it leaks it is probably a bug.


-Andi
