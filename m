Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbTA0TDJ>; Mon, 27 Jan 2003 14:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266839AbTA0TDJ>; Mon, 27 Jan 2003 14:03:09 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:37641 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262040AbTA0TDI>;
	Mon, 27 Jan 2003 14:03:08 -0500
Date: Mon, 27 Jan 2003 20:12:25 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jerry Cooperstein <coop@axian.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030127191225.GA3707@mars.ravnborg.org>
Mail-Followup-To: Jerry Cooperstein <coop@axian.com>,
	linux-kernel@vger.kernel.org
References: <200301231459.22789.schlicht@uni-mannheim.de> <20030127185228.GA8820@p3.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030127185228.GA8820@p3.attbi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 10:52:28AM -0800, Jerry Cooperstein wrote:
> The solution
> 
> make -C KERNEL_SOURCE SUBDIRS=$PWD modules
> 
> is fine, but you have to have a Makefile in the current directory,
> and that Makefile needs a somewhat different form for 2.4 and
> 2.5 kernels.

Notes solely to the Kernel 2.5 part of your script:

1) You do not need any targets like all: or mmodules:
2) The clean: rule will not be used in 2.5, use clean-files instead.
3) No reason to special case on .ko or not. .ko will not harm on 2.4
4) I cannot see any reason to declare all OBJS as .PHONY
5) It looks like you try to enable the use of make in the directory
   where the module exists.
   This is an unusual extension, which will clutter up the makefile
   a bit.
   I would prefer a mmake script or similar that did the make -c ... trick.

	Sam
