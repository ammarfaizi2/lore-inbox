Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVBKXn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVBKXn0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 18:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbVBKXnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 18:43:25 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:1449 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261387AbVBKXnV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 18:43:21 -0500
Date: Sat, 12 Feb 2005 00:44:28 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Holger Waechtler <holger@qanu.de>
Cc: Adrian Bunk <bunk@stusta.de>, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Message-ID: <20050211234428.GB21667@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Holger Waechtler <holger@qanu.de>, Adrian Bunk <bunk@stusta.de>,
	linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
References: <20050211163436.GB2958@stusta.de> <420D05DE.6020706@qanu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420D05DE.6020706@qanu.de>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: 217.86.177.95
Subject: Re: [linux-dvb-maintainer] Re: [RFC: 2.6 patch] DVB: possible cleanups
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holger Waechtler wrote:
> Adrian Bunk wrote:
> 
> >Before I'm getting flamed to death:
> >This patch contains possible cleanups. If parts of this patch conflict 
> >with pending changes these parts of my patch have to be dropped.
> >
> >This patch contains the following possible cleanups:
> >- make needlessly global code static
> >- remove the following EXPORT_SYMBOL'ed but unused function:
> > - bt8xx/bt878.c: bt878_find_by_i2c_adap
> >- remove the following unused global functions:
> > - dvb-core/dvb_demux.c: dmx_get_demuxes
> > - dvb-core/dvb_demux.c: dvb_set_crc32
> >- remove the following unneeded EXPORT_SYMBOL's:
> > - dvb-core/dvb_demux.c: dvb_dmx_swfilter_packet
> 
> dvb_dmx_swfilter_packet() should remain exported to the public, 
> accessing this directly makes sense for some architectures.

Hm, I don't know any out-of-tree driver which is using it. Do you?
Besides, it is roughly equivalent to dvb_dmx_swfilter_packets(demux, buf, 1)
(the difference is in locking and the test for the MPEG-2 TS sync byte).
IMHO the EXPORT_SYMBOL for dvb_dmx_swfilter_packet() can be removed.

To me the patches look good and I'm going to apply them to linuxtv.org CVS.

Thanks,
Johannes

PS: The linuxtv.org server will be down for maintenance over the
weekend which includes the linux-dvb-maintainer list. No need to worry.
