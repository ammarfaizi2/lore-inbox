Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWGGO4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWGGO4e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 10:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWGGO4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 10:56:34 -0400
Received: from pat.uio.no ([129.240.10.4]:14009 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932177AbWGGO4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 10:56:33 -0400
Subject: Re: ext4 features
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Ric Wheeler <ric@emc.com>, "J. Bruce Fields" <bfields@fieldses.org>,
       Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <44ADD223.9010005@tmr.com>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	 <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com>
	 <20060705125956.GA529@fieldses.org> <44AC2B56.8010703@tmr.com>
	 <20060705214133.GA28487@fieldses.org>  <44AC7647.2080005@tmr.com>
	 <1152189796.5689.17.camel@lade.trondhjem.org> <44ADC3CE.1030302@tmr.com>
	 <44ADCA0C.90401@emc.com> <1152240419.6092.16.camel@lade.trondhjem.org>
	 <44ADD223.9010005@tmr.com>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 10:56:10 -0400
Message-Id: <1152284170.5726.38.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.362, required 12,
	autolearn=disabled, AWL 1.45, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 23:16 -0400, Bill Davidsen wrote:

> In most cases you don't care and would be using locking if you did. The 
> old value was valid when you read it, the new value is valid, and if 
> data is changing in 2us and the change matters, you can't process the 
> data before it changes again (or at least may change).

Wrong! The NFS cache consistency model (close-to-open cache consistency)
requires you to be able to revalidate the cache on open() whether or not
you are using posix locking. In fact, most alternatives to posix locking
(for instance dotlocking, which is frequently used by email
applications) rely heavily on this.

See for instance http://nfs.sourceforge.net/#faq_a8

  Trond

