Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbTFJFwv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 01:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbTFJFwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 01:52:51 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:5883 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S262382AbTFJFwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 01:52:50 -0400
Subject: Re: OOPS w83781d during rmmod (2.5.70-bk1[1234])
From: Martin Schlemmer <azarah@gentoo.org>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@Stimpy.netroedge.com>
In-Reply-To: <20030610054107.GA22719@earth.solarsys.private>
References: <20030524183748.GA3097@earth.solarsys.private>
	 <3ED8067E.1050503@paradyne.com>
	 <20030601143808.GA30177@earth.solarsys.private>
	 <20030602172040.GC4992@kroah.com>
	 <20030605023922.GA8943@earth.solarsys.private>
	 <20030605194734.GA6238@kroah.com>
	 <1055136870.5280.196.camel@workshop.saharacpt.lan>
	 <20030610054107.GA22719@earth.solarsys.private>
Content-Type: text/plain
Organization: 
Message-Id: <1055224269.5280.217.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 10 Jun 2003 07:51:10 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-10 at 07:41, Mark M. Hoffman wrote:
> * Martin Schlemmer <azarah@gentoo.org> [2003-06-09 07:34:30 +0200]:
> > 
> > Anyhow, Only change I have made to the w83781d driver, is one line
> > (just tell it to that if the chip id is 0x72, its also of type
> > w83726HF), but now (2.5.70-bk1[123]) it segfaults for me on rmmod, where
> > it did not with 2.5.68 kernels when I still had the other board.  I will
> > attach a oops tomorrow or such when I get home.
> 
> I reproduced the segfault here.  It looks like i2c_del_driver() tries
> to call w83781d_detach_client() more than once now, partly because of
> the safe list fix in 2.5.70-bk11.  But that function should only be
> called for the "primary" client, not the subclients.
> 
> The quick/ugly patch below fixes the symptom, but maybe not the disease.
> There might be more fundamental brokenness in the whole subclient scheme.
> I'll keep looking when I get the chance.
> 

Ok, I will give it a go tonight.  I already sent the oops to the
list before reading this if need be ...


Regards,

-- 
Martin Schlemmer


