Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbTIXTvh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 15:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbTIXTvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 15:51:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37339 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261347AbTIXTvg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 15:51:36 -0400
Date: Wed, 24 Sep 2003 20:51:33 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: olof@austin.ibm.com
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.4] Re: /proc/ioports overrun patch
Message-ID: <20030924195133.GY7665@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.55L.0308291025340.21063@freak.distro.conectiva> <Pine.A41.4.44.0309241437330.22232-100000@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.A41.4.44.0309241437330.22232-100000@forte.austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 24, 2003 at 02:42:44PM -0500, olof@austin.ibm.com wrote:
> Marcelo,
> 
> On Fri, 29 Aug 2003, Marcelo Tosatti wrote:
> 
> > Your change to do_resource_list() will avoid copying out of bound by
> > truncating the resource output. Which means users might get truncated
> > information (only information that fits in the buffer) and not the full
> > information.
> >
> > Is that correct?
> >
> > If so, I would prefer to have a fix which outputs the full resource
> > information. For that we would need seq_file().
> 
> I finally got some time to revisit this and convert /proc/ioports and
> /proc/iomem to seq_file. See below patch -- it's backed against the
> current BK tree.

Hmm...  Why not make the iterator traverse the resource tree instead?
After all, all it takes is addition of pointer to parent resource into
struct resource.  Goes for both 2.4 and 2.6...
