Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWERHjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWERHjk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 03:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWERHjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 03:39:40 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:33408 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751300AbWERHjj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 03:39:39 -0400
Date: Thu, 18 May 2006 00:42:36 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, Christian.Limpach@cl.cam.ac.uk,
       xen-devel@lists.xensource.com, ian.pratt@xensource.com
Subject: Re: [RFC PATCH 08/35] Add Xen-specific memory management definitions
Message-ID: <20060518074236.GU23243@moss.sous-sol.org>
References: <20060509084945.373541000@sous-sol.org> <20060509085151.047254000@sous-sol.org> <20060517090645.0b72bd2d.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060517090645.0b72bd2d.zaitcev@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pete Zaitcev (zaitcev@redhat.com) wrote:
> On Tue, 09 May 2006 00:00:08 -0700, Chris Wright <chrisw@sous-sol.org> wrote:
> 
> > +static inline unsigned long pfn_to_mfn(unsigned long pfn)
> > +{
> > +#ifndef CONFIG_XEN_SHADOW_MODE
> > +	if (xen_feature(XENFEAT_auto_translated_physmap))
> > +		return pfn;
> > +	return phys_to_machine_mapping[(unsigned int)(pfn)] &
> > +		~FOREIGN_FRAME_BIT;
> > +#else
> > +	return pfn;
> > +#endif
> > +}
> 
> Why do we need several modes in Linux guests?

This patchset only supports shadow translated mode, so the extra CONFIG is
just an artifact of this simplied patchset.  Ultimately, this is not the
preferred mode (performance wise), but shadow mode is simpler to port to.
