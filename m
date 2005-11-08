Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbVKHIq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbVKHIq1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 03:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVKHIq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 03:46:26 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:4762 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932496AbVKHIqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 03:46:25 -0500
Subject: Re: [PATCH 2/18] cleanups and bug fix in do_loopback()
From: Ram Pai <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@ftp.linux.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1EZNRz-0007EM-00@dorka.pomaz.szeredi.hu>
References: <E1EZInj-0001Ef-9Z@ZenIV.linux.org.uk>
	 <E1EZNRz-0007EM-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1131439567.5400.221.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 08 Nov 2005 00:46:07 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 22:59, Miklos Szeredi wrote:
> > - check_mnt() on the source of binding should've been unconditional from
> > the very beginning.  My fault - as far I could've trace it, that's an
> > old thinko made back in 2001.  Kudos to Miklos for spotting it...
> > Fixed.
> > - code cleaned up.
> 
> Can you please explain what purpose does this serve?
> 
> AFAICS check_mnt() was there to ensure that operations are done under
> the proper namespace semaphore.

> Next in the series the namespace semaphore is made global, which
> basically means, that most of the check_mnt() invocations become
> useless.
> The ones which as a side effect prevent grafting to a detached mount
> can be changed to check for (mnt->mnt_namespace == NULL) instead of
> check against current->namespace.
> 
> I see no other reason for wanting to prevent binds from detached
> mounts or other namespaces.  It has been discussed that it would be a
> good _controlled_ way to send/receive mounts from other namespace
> without adding any complexity.

AFAICT, the ability to bind across namespaces defeats the private-ness
property of per-process-namespaces. 

RP


