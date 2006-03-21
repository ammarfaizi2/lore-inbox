Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751707AbWCUNh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbWCUNh2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbWCUNh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:37:27 -0500
Received: from zombie.ncsc.mil ([144.51.88.131]:24514 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751696AbWCUNh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:37:26 -0500
Subject: Re: [PATCH] scm: fold __scm_send() into scm_send()
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Chris Wright <chrisw@sous-sol.org>
Cc: James Morris <jmorris@namei.org>, Andrew Morton <akpm@osdl.org>,
       cxzhang@watson.ibm.com, netdev@axxeo.de, ioe-lkml@rameria.de,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <1142947952.28120.29.camel@moss-spartans.epoch.ncsc.mil>
References: <200603130139.k2D1dpSQ021279@shell0.pdx.osdl.net>
	 <200603132105.32794.ioe-lkml@rameria.de>
	 <20060313173103.7681b49d.akpm@osdl.org>
	 <200603201244.58507.netdev@axxeo.de>
	 <20060320201802.GS15997@sorel.sous-sol.org>
	 <20060320213636.GT15997@sorel.sous-sol.org>
	 <20060320143103.31b7d933.akpm@osdl.org>
	 <20060320231508.GV15997@sorel.sous-sol.org>
	 <1142947952.28120.29.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 21 Mar 2006 08:42:08 -0500
Message-Id: <1142948528.28120.34.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 08:32 -0500, Stephen Smalley wrote:
> > I don't expect security_sk_sid() to be terribly expensive.  It's not
> > an AVC check, it's just propagating a label.  But I've not done any
> > benchmarking on that.
> 
> No permission check there, but it looks like it does read lock
> sk_callback_lock.  Not sure if that is truly justified here.

Ah, that is because it is also called from the xfrm code, introduced by
Trent's patches.  But that locking shouldn't be necessary from scm_send,
right?  So she likely wants a separate hook for it to avoid that
overhead, or even just a direct SELinux interface?
  
-- 
Stephen Smalley
National Security Agency

