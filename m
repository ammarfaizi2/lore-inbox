Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267994AbUHKIrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267994AbUHKIrm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 04:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267997AbUHKIrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 04:47:42 -0400
Received: from palrel13.hp.com ([156.153.255.238]:41392 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S267994AbUHKIrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 04:47:40 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16665.56613.143598.768389@napali.hpl.hp.com>
Date: Wed, 11 Aug 2004 01:47:33 -0700
To: James Morris <jmorris@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kurt Garloff <garloff@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] [LSM] Rework LSM hooks
In-Reply-To: <Xine.LNX.4.44.0408101630250.9412-100000@dhcp83-76.boston.redhat.com>
References: <20040810131217.Q1924@build.pdx.osdl.net>
	<Xine.LNX.4.44.0408101630250.9412-100000@dhcp83-76.boston.redhat.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 10 Aug 2004 16:31:12 -0400 (EDT), James Morris <jmorris@redhat.com> said:

  James> On Tue, 10 Aug 2004, Chris Wright wrote:
  >> Thanks, James.  Since these are the only concrete numbers and
  >> they are in the noise, I see no compelling reason to change to
  >> unlikely().

  James> There may be some way to make it ia64 specific.  Is it a cpu
  James> issue, or compiler?

I'm pretty sure the "unlikely()" part could be dropped with little/no
downside.  The part that's relatively expensive (10 cycles when
mispredicted) is the indirect call.  GCC doesn't handle this well on
ia64 and as a result, most indirect calls are mispredicted.

An alternative solution might be to have a call_likely() macro, where
you could predict the most likely target of an indirect call.  Perhaps
that could help other platforms as well.

	--david
