Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbWHNV3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWHNV3W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 17:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWHNV3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 17:29:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57996 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964955AbWHNV3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 17:29:21 -0400
Subject: Re: 2.6.18-rc3-mm2:  oops in device_bind_driver()
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       Linux DVB <linux-dvb@linuxtv.org>
In-Reply-To: <20060814210308.GH11673@kroah.com>
References: <1155385726.6151.6.camel@Homer.simpson.net>
	 <20060812180256.445caea9.akpm@osdl.org>
	 <1155448234.7068.1.camel@Homer.simpson.net>
	 <20060814210308.GH11673@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 14 Aug 2006 18:28:54 -0300
Message-Id: <1155590934.13789.19.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Seg, 2006-08-14 às 14:03 -0700, Greg KH escreveu:
> On Sun, Aug 13, 2006 at 05:50:34AM +0000, Mike Galbraith wrote:
> > On Sat, 2006-08-12 at 18:02 -0700, Andrew Morton wrote:
> > 
> > > I'd assume that you have CONFIG_PCI_MULTITHREAD_PROBE set, and
> > 
> > Yes.
> 
> Mauro, this is odd.  Anything in the dvb layer that would not like
> multiple devices being probed at the same time?
We should hardly check for all race conditions. It is likely to cause
some random troubles at both V4L and DVB sides. 

For example, on V4L side, this may produce weird stuff like bad device
number associations (for example, the same device might get /dev/video0
and /dev/radio1, but apps expects to have the same numbering for
both)...

The same on DVB: demux0 should be associated with frontend0, for DVB to
work properly, but, with simultaneous probing, this might not happen.

For sure some newer locks will be required for multithread probe.
> 
> thanks,
> 
> greg k-h
Cheers, 
Mauro.

