Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbWEJLzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWEJLzZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 07:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWEJLzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 07:55:25 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:62900 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964927AbWEJLzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 07:55:25 -0400
Date: Wed, 10 May 2006 06:55:21 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>, herbert@13thfloor.at,
       dev@sw.ru, sam@vilain.net, xemul@sw.ru, haveblue@us.ibm.com,
       clg@fr.ibm.com, frankeh@us.ibm.com
Subject: Re: [PATCH 1/9] nsproxy: Introduce nsproxy
Message-ID: <20060510115520.GA25720@sergelap.austin.ibm.com>
References: <29vfyljM.2006059-s@us.ibm.com> <20060510021129.GB32523@sergelap.austin.ibm.com> <20060510100057.GA27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510100057.GA27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Al Viro (viro@ftp.linux.org.uk):
> On Tue, May 09, 2006 at 09:11:29PM -0500, Serge E. Hallyn wrote:
> > Introduce the nsproxy struct.  Doesn't do anything yet, but has it's
> > own lifecycle pretty much mirrorring the fs namespace.
> > 
> > Subsequent patches will move the namespace struct into the nsproxy.
> > Then as more namespaces are introduced, such as utsname, they can
> > be added to the nsproxy as well.
> 
> Is there any reason why those can't be simply part of namespace?  I.e.
> be carried by the stuff mounted in standard places...

The argument has been that it is desirable to be able to unshare these
namespaces - uid, pid, network, sysv, utsname, fs-namespace -
separately.  Are you talking about having these all be part of a single
namespace unshared all at once (and stored in struct namespace)?  Or am
I misunderstandimg you entirely?

Andi Kleen (I believe) thinks it should be like that, all or nothing.  I
think Herbert Poetzl had current examples where vserver is used to
unshare just pieces, i.e. apache unsharing network but sharing global
pidspace.

thanks,
-serge
