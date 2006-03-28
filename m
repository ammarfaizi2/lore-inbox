Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWC1Nxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWC1Nxp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 08:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWC1Nxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 08:53:45 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:62362 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932213AbWC1Nxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 08:53:44 -0500
Date: Tue, 28 Mar 2006 07:53:39 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] split security_key_alloc into two functions
Message-ID: <20060328135339.GE19243@sergelap.austin.ibm.com>
References: <20060328130533.GB19243@sergelap.austin.ibm.com> <1143553407.3037.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143553407.3037.8.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Tue, 2006-03-28 at 07:05 -0600, Serge E. Hallyn wrote:
> > The security_key_alloc() function acted as both an authorizer and
> > security structure allocation function.  These roles should be
> > separated.  There are two reasons for this.
> > 
> > First, if two modules are stacked, the first module might grant
> > permission and allocate security data, after which the second
> > module refuses permission.
> > 
> > Second, by adding a security_post_alloc() function after the
> > serial number has been assigned, security modules can append
> > useful info.
> 
> Are you sure that the key cannot be accessed (looked up) by another
> process as soon as it is assigned a serial number?  If it can be, then
> you risk having it accessed before its security structure is set up.

Ah, that makes sense, and even rings a bell.

So if we were to add a post_alloc() hook, it should likely go into
key_alloc_serial() under the key_serial_lock?

Still assuming that storing the serial number is desirable...

thanks,
-serge
