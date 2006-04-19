Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWDSMjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWDSMjU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 08:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWDSMjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 08:39:20 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:55218 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750731AbWDSMjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 08:39:19 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Crispin Cowan <crispin@novell.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Karl MacMillan <kmacmillan@tresys.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@namei.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
In-Reply-To: <444552A7.2020606@novell.com>
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com>
	 <1145381250.19997.23.camel@jackjack.columbia.tresys.com>
	 <44453E7B.1090009@novell.com>
	 <1145391969.21723.41.camel@localhost.localdomain>
	 <444552A7.2020606@novell.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 19 Apr 2006 08:40:36 -0400
Message-Id: <1145450436.24289.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-18 at 13:57 -0700, Crispin Cowan wrote:
> SELinux has NSA legacy, and that is reflected in their inode design: it
> is much better at protecting secrecy, which is the NSA's historic
> mission. AppArmor has legacy in intrusion prevention, and so its primary
> design goal was to prevent compromised programs from compromising the
> host. Name-based access control is better at that, because it lets you
> directly control which programs can change the contents of path names
> that have critical semantic meaning in UNIX/Linux, such as /etc/shadow,
> /etc/hosts.allow, /srv/www/htdocs/index.html and so forth.

This is bunk, pure and simple.  The core security model of SELinux is
Type Enforcement, and Type Enforcement was originally used for
integrity, as a mechanism for complementing and filling in the gaps left
by the MLS (secrecy/confidentiality) model.  Type Enforcement can be
used for confidentiality as well, as it is just a simplification of the
Lampson access matrix, but its original goals were integrity oriented.
Name-based access control is _not_ better for integrity.  You don't want
trusted program FOO (e.g. /bin/su) to accept data from an untrustworthy
file that happens to be named /etc/shadow in your namespace, so you want
your integrity controls to be governed by the real security attributes
of the real object, not just its name.  The only argument I've seen
regarding "names are better for integrity" is that it is easier to
preserve the association when the object is re-created at that location.
But that association may be fallacious - if an untrustworthy process
re-created /etc/shadow, I don't want it to retain an association with
high integrity data.

-- 
Stephen Smalley
National Security Agency

