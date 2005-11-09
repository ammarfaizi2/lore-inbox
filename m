Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbVKITIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbVKITIm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 14:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbVKITIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 14:08:41 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:1686 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030292AbVKITIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 14:08:41 -0500
Subject: Re: [PATCH 2/18] cleanups and bug fix in do_loopback()
From: Ram Pai <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@ftp.linux.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1EZPm4-0007R7-00@dorka.pomaz.szeredi.hu>
References: <E1EZInj-0001Ef-9Z@ZenIV.linux.org.uk>
	 <E1EZNRz-0007EM-00@dorka.pomaz.szeredi.hu>
	 <1131439567.5400.221.camel@localhost>
	 <E1EZPm4-0007R7-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1131563299.5400.392.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 09 Nov 2005 11:08:19 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 01:28, Miklos Szeredi wrote:
> > > I see no other reason for wanting to prevent binds from detached
> > > mounts or other namespaces.  It has been discussed that it would be a
> > > good _controlled_ way to send/receive mounts from other namespace
> > > without adding any complexity.
> > 
> > AFAICT, the ability to bind across namespaces defeats the private-ness
> > property of per-process-namespaces. 
> 
> No.  The privateness is guaranteed by proc_check_root(), which is
> similar, but not the same as check_mnt(), and wich restrict _access_
> to other namespaces.
> check_mnt() restricts operations on other namespaces if you _already_
> have access to said namespace.  For example via a file descriptor sent
> between two processes in different namespaces.

 Yes there is some contradiction of some sorts on this. private-ness
means that the namespace must _not_ be accesible to processes
in other namespace. But 'file descriptor sent between two processes in
different namespaces' seems to break that guarantee.  

> 
> Also with ptrace() you can still access other process's namespace, so
> proc_check_root() is also too strict (or ptrace() too lax).

same here.

RP

> 
> Miklos

