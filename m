Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVEaVNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVEaVNM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 17:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVEaVNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 17:13:12 -0400
Received: from free.hands.com ([83.142.228.128]:17552 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S261506AbVEaVMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 17:12:41 -0400
Date: Tue, 31 May 2005 22:21:12 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
       "'Stephen Smalley'" <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov,
       dwalsh@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: file_type_auto_trans is not sufficient
Message-ID: <20050531212112.GF11815@lkcl.net>
Mail-Followup-To: Ivan Gyurdiev <ivg2@cornell.edu>,
	Karl MacMillan <kmacmillan@tresys.com>,
	'Stephen Smalley' <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov,
	dwalsh@redhat.com, linux-kernel@vger.kernel.org
References: <200505311412.j4VECK5F030983@gotham.columbia.tresys.com> <1117551440.15167.25.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117551440.15167.25.camel@dhcp83-8.boston.redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 10:57:20AM -0400, Ivan Gyurdiev wrote:
> 
> > The other option, of course, is to change the applications to use/create many
> > more directories, each with a separate type to allow the file_type_auto_trans
> > rules to work. Your orbit example might mean that there is a /tmp/orbit
> > directory where all orbit files are created.
> 
> The problem is not multiple source domains - that can be addressed
> through macros. The problem is that those domains use the same directory
> (Usually /tmp, or /home), for their own purposes, and they need the same
> transition (same directory and target class (dir/file)). 
> 
> Because you can have only one transition, this creates a problem.
 
 ...

 thinking "sideways" again - as i am wont to do.

 how about... a "sideways" solution to this - at the kernel level?

 a "silent" redirection / remount, on a per-application basis?

 no, i'm not joking.

 an option to "mount" which allows a specific APPLICATION (or group of
 applications) to have any files/directories it creates/accesses in a
 subdirectory ACTUALLY occur ELSEWHERE.

 e.g.:

 mount -o redirectexe=/usr/bin/mozilla-firefox /tmp /tmp/mozilla
 mount -o redirectexe=/usr/bin/gnomeshite,/usr/bin/gnomemoreshite /tmp /tmp/gconf

 hm, that could get out-of-hand - the number of programs involved
 that would need redirection..

 *thinks* ... some other mechanism for "grouping" executables...

 you could even hang it off of an selinux context (!) or selinux domain
 (!) such that a set of executables, possibly those executed by
 certain users, would result in filesystem redirection - but not others.

 at your own discretion.

 then, you _could_ specify /tmp/gconf equals "a different file context".

 l.

