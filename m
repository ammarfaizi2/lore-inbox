Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVAYH6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVAYH6w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 02:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVAYH4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 02:56:31 -0500
Received: from h80ad25f5.async.vt.edu ([128.173.37.245]:29188 "EHLO
	h80ad25f5.async.vt.edu") by vger.kernel.org with ESMTP
	id S261870AbVAYHzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 02:55:19 -0500
Message-Id: <200501250755.j0P7tA7C029953@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Complex logging in the kernel 
In-Reply-To: Your message of "Tue, 25 Jan 2005 01:26:14 EST."
             <41F5E686.1080205@comcast.net> 
From: Valdis.Kletnieks@vt.edu
References: <41F5E686.1080205@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1106639710_11132P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Jan 2005 02:55:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1106639710_11132P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <1859.1106639710.1@turing-police.cc.vt.edu>

On Tue, 25 Jan 2005 01:26:14 EST, John Richard Moser said:

> For example, let's say I wanted to register my specific code (i.e. a
> security module) to log, and adjust to log level N.  I also want another
> module to log at log level L, which is lower than N.  I want to print
> logs at log level N..+2 and below to the console, but silently log all
> log messages >N+2 to the syslog.
> 
> Anything?

from include/linux/kern.h:

#define KERN_EMERG      "<0>"   /* system is unusable                   */
#define KERN_ALERT      "<1>"   /* action must be taken immediately     */
#define KERN_CRIT       "<2>"   /* critical conditions                  */
#define KERN_ERR        "<3>"   /* error conditions                     */
#define KERN_WARNING    "<4>"   /* warning conditions                   */
#define KERN_NOTICE     "<5>"   /* normal but significant condition     */
#define KERN_INFO       "<6>"   /* informational                        */
#define KERN_DEBUG      "<7>"   /* debug-level messages                 */

Do all your printk in one module at KERN_NOTICE, and the other at KERN_INFO,
and then use klogd and syslogd to route them as you want.

Or use something like syslog-ng to route based on a regexp match, and then
just make sure your printk's include the module name, log everything at one
level, and route matches for 'modulea:' to one place and 'moduleb:' to
another.

Alternatively, use the 'audit' subsystem - but there you'll probably have to
modify the userspace auditd to recognize messages from the various modules and
route them appropriately.

If you're looking for a learning experience rather than getting code
completed, you can probably find a way to use netlink to do it too....

--==_Exmh_1106639710_11132P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB9ftecC3lWbTT17ARArRpAKD19L10ehxuVmiuNbHjJxQq4ckWgwCeNFOK
P3HJyvgqIqSMqNL562AwaXw=
=dMnq
-----END PGP SIGNATURE-----

--==_Exmh_1106639710_11132P--
