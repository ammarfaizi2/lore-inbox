Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbVADXqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbVADXqk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbVADXho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:37:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:438 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262120AbVADXXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 18:23:21 -0500
Date: Tue, 4 Jan 2005 15:23:17 -0800
From: Chris Wright <chrisw@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] properly split capset_check+capset_set
Message-ID: <20050104152317.B2357@build.pdx.osdl.net>
References: <20050104162745.GA400@IBM-BWN8ZTBWA01.austin.ibm.com> <1104857632.17166.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1104857632.17166.35.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Tue, Jan 04, 2005 at 10:03:59PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> On Maw, 2005-01-04 at 16:27, Serge E. Hallyn wrote:
> > The attached patch removes checks from kernel/capability.c which are
> > redundant with cap_capset_check() code, and moves the capset_check()
> > calls to immediately before the capset_set() calls.  This allows
> > capset_check() to accurately check the setter's permission to set caps
> > on the target.  Please apply.
> 
> Why does this help ?

Without this change, the check was done without knowing who the target
really was, so the code that sets it had to check as well.

> A partial failure now returns no error ?

It never did.  Now it behaves the same as signal delivery which returns
success if any signals were delivered, and failure if none were delivered.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
