Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWDSHoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWDSHoK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 03:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWDSHoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 03:44:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33731 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750736AbWDSHoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 03:44:09 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Arjan van de Ven <arjan@infradead.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: casey@schaufler-ca.com, James Morris <jmorris@namei.org>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
In-Reply-To: <CD11FD59-4E2E-4AD7-9DD0-5811CE792B24@mac.com>
References: <20060419014857.35628.qmail@web36606.mail.mud.yahoo.com>
	 <CD11FD59-4E2E-4AD7-9DD0-5811CE792B24@mac.com>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 09:44:05 +0200
Message-Id: <1145432645.3085.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 02:40 -0400, Kyle Moffett wrote:
> On Apr 18, 2006, at 21:48:56, Casey Schaufler wrote:
> > --- James Morris <jmorris@namei.org> wrote:
> >> With pathnames, there is an unbounded and unknown number of  
> >> effective security policies on the system, as there are an
> >> unbounded and unknown number of ways of viewing the files via  
> >> pathnames.
> >
> > I agree that for traditional DAC and MAC (including the flavors  
> > supported by SELinux) inodes is the only way to go. SELinux is a  
> > traditional Trusted OS architecture and addresses the traditional  
> > Trusted OS issues.
> 
> Perhaps the SELinux model should be extended to handle (dir-inode,  
> path-entry) pairs.  For example, if I want to protect the /etc/shadow  
> file regardless of what tool is used to safely modify it, I would set  
> up security as follows:
> 
> o  Protect the "/" and "/etc" directory inodes as usual under SELinux  
> (with attributes on directory inodes).

in which namespace are these? And are they in a chroot?
And what if someone makes /etd a symlink to /etc :)
And what if I bind-mount something on top of /etc/shadow ?
or unlink the file while holding it open? Should the security suddenly
go away? There's no "directory" for this file anymore at that point.
Or if I hardlink /etc/shadhow to /tmp/shad ... what then?


> o  Create pairs with (etc_inode,"shadow") and (etc_inode,"gshadow")  
> and apply security attributes to those potentially nonexistent pairs

again see above ;_)

> .
> 
> I'm not terribly familiar with the exact internal semantics of  
> SELinux, but that should provide a 90% solution (it fixes bind mounts  
> and namespaces).

how does this fix namespaces or even bind mounts?
(or even symlinks for that matter)


