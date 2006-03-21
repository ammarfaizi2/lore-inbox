Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbWCUN2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbWCUN2O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbWCUN2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:28:14 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:60105 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1030373AbWCUN2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:28:13 -0500
Subject: Re: [PATCH] scm: fold __scm_send() into scm_send()
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Chris Wright <chrisw@sous-sol.org>
Cc: James Morris <jmorris@namei.org>, Andrew Morton <akpm@osdl.org>,
       cxzhang@watson.ibm.com, netdev@axxeo.de, ioe-lkml@rameria.de,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20060320231508.GV15997@sorel.sous-sol.org>
References: <200603130139.k2D1dpSQ021279@shell0.pdx.osdl.net>
	 <200603132105.32794.ioe-lkml@rameria.de>
	 <20060313173103.7681b49d.akpm@osdl.org>
	 <200603201244.58507.netdev@axxeo.de>
	 <20060320201802.GS15997@sorel.sous-sol.org>
	 <20060320213636.GT15997@sorel.sous-sol.org>
	 <20060320143103.31b7d933.akpm@osdl.org>
	 <20060320231508.GV15997@sorel.sous-sol.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 21 Mar 2006 08:32:32 -0500
Message-Id: <1142947952.28120.29.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-20 at 15:15 -0800, Chris Wright wrote:
> * Andrew Morton (akpm@osdl.org) wrote:
> > Chris Wright <chrisw@sous-sol.org> wrote:
> > > Catherine, the security_sid_to_context() is a raw SELinux function which
> > > crept into core code and should not have been there.  The fallout fixes
> > > included conditionally exporting security_sid_to_context, and finally
> > > scm_send/recv unlining.
> > 
> > Yes.  So we're OK up the uninlining, right?
> 
> Yes, although sid_to_context is meant to be analog to the other
> get_peersec calls, and should really be made a proper part of the
> interface (can be done later, correctness is the issue at hand).

Yes, Catherine was told that she shouldn't be directly exporting
security_sid_to_context, and was allegedly working on a fix.  Note
however that the expected solution is not a LSM interface but a set of
properly encapsulated interfaces exported directly from SELinux, based
on the iptables context matching patches by James.  The same style of
interface is being put forth for the audit LSPP work.  The indirection
of LSM serves no purpose here, as these users are specifically looking
for functionality provided only by SELinux.

> I don't expect security_sk_sid() to be terribly expensive.  It's not
> an AVC check, it's just propagating a label.  But I've not done any
> benchmarking on that.

No permission check there, but it looks like it does read lock
sk_callback_lock.  Not sure if that is truly justified here.

-- 
Stephen Smalley
National Security Agency

