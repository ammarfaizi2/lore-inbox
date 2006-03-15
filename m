Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWCOEmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWCOEmM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 23:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWCOEmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 23:42:12 -0500
Received: from mail.gmx.de ([213.165.64.20]:10708 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932174AbWCOEmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 23:42:11 -0500
X-Authenticated: #427522
Message-ID: <44179C77.1010902@gmx.de>
Date: Wed, 15 Mar 2006 05:47:51 +0100
From: Mathis Ahrens <Mathis.Ahrens@gmx.de>
User-Agent: Mail/News 1.5 (X11/20060206)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Sam Ravnborg <sam@ravnborg.org>
Subject: [2.6.16-rc6] CONFIG_LOCALVERSION_AUTO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

i just discovered this cute little feature, but had three
minor issues while experimenting with it on 2.6.16-rc6:

1.
Semantics of LOCALVERSION are confusing and probably buggy.
The Makefile states:

# Take the contents of any files called localversion* and the config
# variable CONFIG_LOCALVERSION and append them to KERNELRELEASE.
# LOCALVERSION from the command line override all of this

whereas my simplified view of current code is:

version = major + minor + patch + extra
release = version + localver-full
localver-full = localver + localver-auto
localver = <concat all localversions*> + $CONFIG_LOCALVERSION
localver-auto = $LOCALVERSION + <some -gxxxxxx>

LOCALVERSION does not seem to /override/ anything if specified on the
command line, but rather (with CONFIG_LOCALVERSION_AUTO=y) gets
/inserted/.

Also, with CONFIG_LOCALVERSION_AUTO=n, specifying LOCALVERSION
on the command line currently does nothing at all. This is a regression
from 2.6.15, I suppose.

2.
"make kernelrelease" does not imply "make .kernelrelease", it only
does cat the file .kernelrelease (or shows an error if it's not there).

This leads to the following IMHO slightly irritating behaviour
$ echo "LV1" > localversion
$ make kernelrelease
2.6.16-rc6LV1
$ echo "LV2" > localversion
$ make kernelrelease
2.6.16-rc6LV1

Is there a reason for this?

3.
The help of CONFIG_LOCALVERSION_AUTO reads:

Note: This requires Perl, and a git repository, but not necessarily
the git or cogito tools to be installed.

Looking at scripts/setlocalversion, this does not seem to be correct
anymore.



Cheers,
Mathis





