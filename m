Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266888AbTAZNY0>; Sun, 26 Jan 2003 08:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbTAZNY0>; Sun, 26 Jan 2003 08:24:26 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:15879 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S266888AbTAZNYZ>;
	Sun, 26 Jan 2003 08:24:25 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: no version magic, tainting kernel. 
In-reply-to: Your message of "Sun, 26 Jan 2003 14:29:23 BST."
             <20030126132923.GB396@kugai> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 27 Jan 2003 00:33:27 +1100
Message-ID: <31273.1043588007@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jan 2003 14:29:23 +0100, 
Christian Zander <zander@minion.de> wrote:
>The new module
>is thus built using gcc 3.0, but init/vermagic.o still indicates gcc
>2.95; the module loader will erroneously believe everything is fine.

Congratulations, you have put your finger on a major design flaw in
modversions that has been there since 2.0 kernel days.  The modversion
data is generated once and everything else blindly uses it, with _NO_
checks on whether it is still valid or not.  Rusty knows damn well that
this is broken, but appears to be ignoring that fact (Rusty, see my
mail to you and Alan Cox on Wed, 24 Oct 2001 14:14:18 +1000).

See http://unc.dl.sourceforge.net/sourceforge/kbuild/kbuild-2.5-history.tar.bz2,
in particular makefile-2.5_whereto.html.  modversions relies on
assumptions that are not valid and therefore modversions are broken, as
noted by Christian Zander and others.

To do module versioning right needs global information about this
definitions and usage of exported symbols.  It was one of the reasons
that kbuild 2.5 had a global database, in order to track symbol usage
and handle ABI versioning correctly.

