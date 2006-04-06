Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWDFRxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWDFRxa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 13:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWDFRxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 13:53:30 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:12998 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751292AbWDFRx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 13:53:29 -0400
In-Reply-To: <1142948528.28120.34.camel@moss-spartans.epoch.ncsc.mil>
To: sds@tycho.nsa.gov
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>,
       cxzhang@watson.ibm.com, davem@davemloft.net, ioe-lkml@rameria.de,
       James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, netdev@axxeo.de
MIME-Version: 1.0
Subject: Re: [PATCH] scm: fold __scm_send() into scm_send()
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFD873D233.5BCDC487-ON85257148.0061E542-85257148.00623838@us.ibm.com>
From: Xiaolan Zhang <cxzhang@us.ibm.com>
Date: Thu, 6 Apr 2006 13:52:48 -0400
X-MIMETrack: Serialize by Router on D01ML605/01/M/IBM(Release 7.0.1HF18 | February 28, 2006) at
 04/06/2006 13:52:54,
	Serialize complete at 04/06/2006 13:52:54
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stephen and James,

Looks like the selinux_sk_ctxid() call implemented in James' patch also 
requires the sk_callback_lock (see below).  I am planning to introduce a 
new exported fucntion selinux_sock_ctxid() which does not require any 
locking.  Comments?

thanks,
Catherine

Stephen Smalley <sds@tycho.nsa.gov> wrote on 03/21/2006 08:42:08 AM:

> On Tue, 2006-03-21 at 08:32 -0500, Stephen Smalley wrote:
> > > I don't expect security_sk_sid() to be terribly expensive.  It's not
> > > an AVC check, it's just propagating a label.  But I've not done any
> > > benchmarking on that.
> > 
> > No permission check there, but it looks like it does read lock
> > sk_callback_lock.  Not sure if that is truly justified here.
> 
> Ah, that is because it is also called from the xfrm code, introduced by
> Trent's patches.  But that locking shouldn't be necessary from scm_send,
> right?  So she likely wants a separate hook for it to avoid that
> overhead, or even just a direct SELinux interface?
> 
> -- 
> Stephen Smalley
> National Security Agency
> 

