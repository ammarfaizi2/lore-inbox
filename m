Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264005AbUCPQ15 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbUCPQUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:20:39 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:12424 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263974AbUCPQRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:17:36 -0500
Date: Tue, 16 Mar 2004 16:16:29 +0000
From: Dave Jones <davej@redhat.com>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       jgarzik@pobox.com
Subject: Re: [3C509] Fix sysfs leak.
Message-ID: <20040316161629.GD17958@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marc Zyngier <mzyngier@freesurf.fr>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org, akpm@osdl.org, jgarzik@pobox.com
References: <200403152147.i2FLl09s002942@delerium.codemonkey.org.uk> <wrpad2hf4be.fsf@panther.wild-wind.fr.eu.org> <20040316134613.GA15600@redhat.com> <wrp3c88g9xu.fsf@panther.wild-wind.fr.eu.org> <20040316142951.GA17958@redhat.com> <wrpwu5kessd.fsf@panther.wild-wind.fr.eu.org> <20040316153018.GB17958@redhat.com> <wrpr7vseq06.fsf@panther.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrpr7vseq06.fsf@panther.wild-wind.fr.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 05:05:45PM +0100, Marc Zyngier wrote:
 >  #ifdef CONFIG_MCA
 >  	mca_register_driver(&el3_mca_driver);
 >  #endif
 > -	return el3_cards ? 0 : -ENODEV;
 > +	return 0;
 >  }
 >  
 >  static void __exit el3_cleanup_module(void)
 > 
 > This is not pretty either, but 3c579 probing will work, and in your
 > case it won't leave a dangling directory in sysfs.

Yes, leaving the module around, and cleaning up at rmmod time should
also work.  I'll test it in a while to be sure.

 > Dave> Why is this even an issue so late on? Bus probing should have
 > Dave> been done as part of bootup. By the time I get to modprobing
 > Dave> device drivers, it should have been determined already.
 > 
 > Modprobing is perfectly OK, and indeed everything has been probed at
 > this stage.

Clearly it hadn't, or otherwise modprobing 3c509 would have failed
due to the lack of an eisa bus.

 > But having built-in drivers raises a few different
 > problems (the driver may be initialized before all busses are probed).

There were no built-in drivers in this case.

		Dave

