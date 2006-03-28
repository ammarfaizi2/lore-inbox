Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWC1OOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWC1OOV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 09:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWC1OOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 09:14:21 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:9356 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S932256AbWC1OOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 09:14:20 -0500
Subject: Re: [PATCH] split security_key_alloc into two functions
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: James Morris <jmorris@namei.org>, lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org,
       David Howells <dhowells@redhat.com>
In-Reply-To: <20060328135339.GE19243@sergelap.austin.ibm.com>
References: <20060328130533.GB19243@sergelap.austin.ibm.com>
	 <1143553407.3037.8.camel@moss-spartans.epoch.ncsc.mil>
	 <20060328135339.GE19243@sergelap.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 28 Mar 2006 09:18:52 -0500
Message-Id: <1143555532.3037.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 07:53 -0600, Serge E. Hallyn wrote:
> Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > Are you sure that the key cannot be accessed (looked up) by another
> > process as soon as it is assigned a serial number?  If it can be, then
> > you risk having it accessed before its security structure is set up.
> 
> Ah, that makes sense, and even rings a bell.
> 
> So if we were to add a post_alloc() hook, it should likely go into
> key_alloc_serial() under the key_serial_lock?
> 
> Still assuming that storing the serial number is desirable...

I'm not sure how/why SELinux would want that information, as we would
just be labeling the key based on its creator (possibly via a transition
computation to allow derived types), and then later possibly support
explicit labeling by security-aware applications as permitted by policy.
Serial number wouldn't be used for access control, and audit is being
handled separately these days (e.g. one might introduce audit hooks to
collect the serial number at the right points for later inclusion in
audit records emitted at syscall exit).

-- 
Stephen Smalley
National Security Agency

