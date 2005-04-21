Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVDUPGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVDUPGM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 11:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVDUPGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 11:06:12 -0400
Received: from palrel11.hp.com ([156.153.255.246]:44700 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261417AbVDUPF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 11:05:56 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16999.49458.498919.807191@napali.hpl.hp.com>
Date: Thu, 21 Apr 2005 08:05:22 -0700
To: tony.luck@intel.com, akpm@osdl.org
Cc: Andreas Hirstius <Andreas.Hirstius@cern.ch>,
       Bartlomiej ZOLNIERKIEWICZ <Bartlomiej.Zolnierkiewicz@cern.ch>,
       Gelato technical <gelato-technical@gelato.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [Gelato-technical] Re: Serious performance degradation on a RAID
 with kernel 2.6.10-bk7 and later
In-Reply-To: <42678EEA.6070109@cern.ch>
References: <42669357.9080604@cern.ch>
	<42668977.5060708@utah-nac.org>
	<42676501.8030805@cern.ch>
	<58cb370e05042102272ce70f2@mail.gmail.com>
	<42677587.8030707@cern.ch>
	<42678EEA.6070109@cern.ch>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony and Andrew,

I just checked 2.6.12-rc3 and the fls() fix is indeed missing.  Do you
know what happened?

	--david

>>>>> On Thu, 21 Apr 2005 13:30:50 +0200, Andreas Hirstius <Andreas.Hirstius@cern.ch> said:

  Andreas> Hi, The fls() patch from David solves the problem :-))

  Andreas> Do you have an idea, when it will be in the mainline
  Andreas> kernel??

  Andreas> Andreas



  Andreas> Bartlomiej ZOLNIERKIEWICZ wrote:

  >>  Hi!
  >> 
  >>> A small update.
  >>> 
  >>> Patching mm/filemap.c is not necessary in order to get the
  >>> improved performance!  It's sufficient to remove
  >>> roundup_pow_of_two from |get_init_ra_size ...
  >>> 
  >>> So a simple one-liner changes to picture dramatically.  But why
  >>> ?!?!?
  >> 
  >> 
  >> roundup_pow_of_two() uses fls() and ia64 has buggy fls()
  >> implementation [ seems that David fixed it but patch is not in
  >> the mainline yet]:
  >> 
  >> http://www.mail-archive.com/linux-ia64@vger.kernel.org/msg01196.html
  >> 
  >> That would also explain why you couldn't reproduce the problem on
  >> ia32 Xeon machines.
  >> 
  >> Bartlomiej
  >> 

  Andreas> _______________________________________________
  Andreas> Gelato-technical mailing list
  Andreas> Gelato-technical@gelato.unsw.edu.au
  Andreas> https://www.gelato.unsw.edu.au/mailman/listinfo/gelato-technical
