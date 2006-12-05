Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756883AbWLEXuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883AbWLEXuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 18:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756952AbWLEXuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 18:50:24 -0500
Received: from mailfe06.tele2.fr ([212.247.154.172]:51136 "EHLO swip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756883AbWLEXuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 18:50:22 -0500
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
X-Cloudmark-Score: 0.000000 []
Date: Wed, 6 Dec 2006 00:50:07 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: linux-kernel@vger.kernel.org
Cc: mrkiko.rs@gmail.com, dave@mielke.cc, sebastien.hinderer@loria.fr
Subject: SAK and screen readers
Message-ID: <20061205235006.GA8273@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org, mrkiko.rs@gmail.com, dave@mielke.cc,
	sebastien.hinderer@loria.fr
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

BrlTTY is a screen reader: it is a deamon run as root on machines used
by blind users for getting the content of the screen via braille or
speech.

BrlTTY, like other screen readers (susebl, yasr, ...) needs to open
/dev/tty0 for performing various actions, namely:

- VT_ACTIVATE
- GIO_UNISCRNMAP
- GIO_UNIMAP
- KDFONTOP
- VT_GETHIFONTMASK
- VT_GETSTATE
- KDGETMODE
- TIOCSTI
- KDGKBMETA
- KDGKBMODE

The problem comes when using SAK: brltty gets killed because it owns an
fd on /dev/tty0.  This is a problem since the blind user then just can't
use her computer any more...

Some of the actions above are not directly related to the current VT, so
these could use a generic VT handle ; but at least KD* and TIOCSTI need
to be directed to the current VT, so brltty really needs to have an fd
on the current VT tty.

Could there be a solution for brltty yet not being killed by SAK? (like
letting brltty just nicely close his fd for the current VT, and then
re-open it later)

Samuel
