Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312326AbSDEG6N>; Fri, 5 Apr 2002 01:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312334AbSDEG6E>; Fri, 5 Apr 2002 01:58:04 -0500
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:14601 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S312326AbSDEG5r>; Fri, 5 Apr 2002 01:57:47 -0500
Date: Fri, 5 Apr 2002 07:57:43 +0100
To: "Jonathan A. Davis" <davis@jdhouse.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch-2.4.19-pre5-ac2
Message-ID: <20020405065743.GA751@berserk.demon.co.uk>
Mail-Followup-To: "Jonathan A. Davis" <davis@jdhouse.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204041720210.1546-100000@penguin.transmeta.com> <Pine.LNX.4.44.0204041958070.1384-100000@bacchus.jdhouse.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@berserk.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 08:19:49PM -0600, Jonathan A. Davis wrote:
> 
> The radeon updates in pre5-ac2 seem to make a minor mess out of my Radeon
> 7500's console fb.  After X starts up -- switching back to a text console
> results in artifacts from the X display contents plus borked scrolling.  
> No tendency to crash though and switching back to X results in a normal X
> display.  I dropped out the patches to:
> 

Yep. The accelerator needs resetting on each console switch so that we
can cope when X leaves it in a funky state. The new patch I posted
yesterday should fix it, or for a quick fix add the lines

	if(accel)
		radeon_engine_init_var();

after the call to do_install_cmap() in radeon_fb_setvar().

P.
