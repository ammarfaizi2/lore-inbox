Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268861AbUJKMXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268861AbUJKMXn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 08:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268868AbUJKMXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 08:23:43 -0400
Received: from linaeum.absolutedigital.net ([63.87.232.45]:48807 "EHLO
	linaeum.absolutedigital.net") by vger.kernel.org with ESMTP
	id S268861AbUJKMXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 08:23:41 -0400
Date: Mon, 11 Oct 2004 08:23:35 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Jan Dittmer <j.dittmer@portrix.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       NetDev Mailing List <netdev@oss.sgi.com>, proski@gnu.org,
       hermes@gibson.dropbear.id.au
Subject: Re: [PATCH] Fix readw/writew warnings in drivers/net/wireless/hermes.h
In-Reply-To: <416A7484.1030703@portrix.net>
Message-ID: <Pine.LNX.4.61.0410110819370.8480@linaeum.absolutedigital.net>
References: <Pine.LNX.4.61.0410110702590.7899@linaeum.absolutedigital.net>
 <416A7484.1030703@portrix.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2004, Jan Dittmer wrote:

> Cal Peake wrote:
> 
> >  	inw((hw)->iobase + ( (off) << (hw)->reg_spacing )) : \
> > -	readw((hw)->iobase + ( (off) << (hw)->reg_spacing )))
> > +	readw((void __iomem *)(hw)->iobase + ( (off) << (hw)->reg_spacing )))
> >  #define hermes_write_reg(hw, off, val) do { \
> 
> Isn't the correct fix to declare iobase as (void __iomem *) ?

iobase is an unsigned long, declaring it as a void pointer is prolly not 
what we want to do here. The typecast seems proper. A lot of other drivers 
do this as well thus it must be proper ;-)

-- Cal

