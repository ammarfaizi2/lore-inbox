Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267146AbSKMJov>; Wed, 13 Nov 2002 04:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267152AbSKMJov>; Wed, 13 Nov 2002 04:44:51 -0500
Received: from bohnice.netroute.lam.cz ([212.71.169.62]:18426 "EHLO
	vagabond.cybernet.cz") by vger.kernel.org with ESMTP
	id <S267146AbSKMJov>; Wed, 13 Nov 2002 04:44:51 -0500
Date: Wed, 13 Nov 2002 10:51:34 +0100
From: Jan Hudec <bulb@ucw.cz>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Adam Voigt <adam@cryptocomm.com>, linux-kernel@vger.kernel.org
Subject: Re: File Limit in Kernel?
Message-ID: <20021113095133.GC21446@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	Andreas Gruenbacher <agruen@suse.de>,
	Adam Voigt <adam@cryptocomm.com>, linux-kernel@vger.kernel.org
References: <1037115535.1439.5.camel@beowulf.cryptocomm.com> <200211121657.20437.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211121657.20437.agruen@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 04:57:20PM +0100, Andreas Gruenbacher wrote:
> On Tuesday 12 November 2002 16:38, Adam Voigt wrote:
> > I have a directory with 39,000 files in it, and I'm trying to use the cp
> > command to copy them into another directory, and neither the cp or the
> > mv command will work, they both same "argument list too long" when I
> > use:
> >
> > cp -f * /usr/local/www/images
> >
> > or
> >
> > mv -f * /usr/local/www/images
> 
> Note that this is not a kernel related question. The * in the command line is 
> expanded into a list of all entries in the current directory, which results 
> in a command line longer than allowed. Try this instead:
> 
> find -maxdepth 1 -print0 | \
> 	xargs -0 --replace=% cp -f % /usr/local/www/images

Find has an -exec operator in the first place, so this is a little:

find -maxdepth 1 -exec cp -f '{}' /usr/local/www/images ';'

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
