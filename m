Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262439AbSI2KHc>; Sun, 29 Sep 2002 06:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262440AbSI2KHb>; Sun, 29 Sep 2002 06:07:31 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:34971 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262439AbSI2KHa>; Sun, 29 Sep 2002 06:07:30 -0400
Date: Sun, 29 Sep 2002 12:10:18 +0200
From: Dominik Brodowski <linux@brodo.de>
To: Gerald Britton <gbritton@alum.mit.edu>
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: Re: [PATCH] Re: [2.5.39] (3/5) CPUfreq i386 drivers
Message-ID: <20020929121018.A811@brodo.de>
References: <20020928112503.E1217@brodo.de> <20020928134457.A14784@brodo.de> <20020928134739.A11797@light-brigade.mit.edu> <20020929111603.F1250@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20020929111603.F1250@brodo.de>; from linux@brodo.de on Sun, Sep 29, 2002 at 11:16:03AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 11:16:03AM +0200, Dominik Brodowski wrote:
> > If I fix the init by moving the !low || !high test below the loop, and prevent
> > bad data from being passed into the notifier chains, I start getting memory
> > corruption being detected by slab poisioning.
> Any idea why this is happening??? The only dynamically allocated struct is
> struct cpfureq_driver driver; and it is only kfree'd in speedstep_exit... 
I think I found the problem: it should be GFP_ATOMIC and not GFP_KERNEL in
the allocation of struct cpufreq_driver. Will be fixed in the next release.


	Dominik
