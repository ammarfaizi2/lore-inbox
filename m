Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWDRNhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWDRNhF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 09:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWDRNhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 09:37:05 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:38639 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750947AbWDRNhD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 09:37:03 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
	implementation of LSM hooks)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Valdis.Kletnieks@vt.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Greg KH <greg@kroah.com>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060418132121.GE7562@sergelap.austin.ibm.com>
References: <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417162345.GA9609@infradead.org>
	 <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417173319.GA11506@infradead.org>
	 <Pine.LNX.4.64.0604171454070.17563@d.namei>
	 <20060417195146.GA8875@kroah.com>
	 <1145309184.14497.1.camel@localhost.localdomain>
	 <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu>
	 <20060418122206.GC7562@sergelap.austin.ibm.com>
	 <1145365186.16632.43.camel@moss-spartans.epoch.ncsc.mil>
	 <20060418132121.GE7562@sergelap.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 18 Apr 2006 09:40:34 -0400
Message-Id: <1145367634.16632.67.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-18 at 08:21 -0500, Serge E. Hallyn wrote:
> Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > I doubt you'd drop capability altogether.  You could incrementally
> > enable the direct granting of capabilities based on SELinux security
> > context by defining a new class in its policy (cap_override) that
> > mirrors the existing capability class, and modifying SELinux to
> > authoritatively grant the capability if it is allowed in that class for
> 
> Subject, I hope, to other selinux permission checks!  (ie "authoritatively"
> meaning over dac checks, not over it's own mac checks)

Authoritatively over the capability module is what I meant, i.e. if
capability X is allowed in a new cap_override access vector for the
process' domain, then allow the process to exercise that capability and
skip the call to the secondary module (capability or dummy).  So you
could allow ping_t to exercise that single capability even if it wasn't
uid 0.  But if it is only allowed in the existing capability access
vector and not in the cap_override vector, then only allow it if both
SELinux and the secondary grant it (existing behavior).

Note btw that another reason it is better to do this via SELinux than by
fs caps is that SELinux already provides the right separation/protection
between processes with different security contexts, whereas the
capability module does not (many inter-process interactions are
presently only governed by uid/gid checking).

-- 
Stephen Smalley
National Security Agency

