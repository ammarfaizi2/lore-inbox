Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264326AbUEDMVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264326AbUEDMVY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 08:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264318AbUEDMVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 08:21:23 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:19409 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S264326AbUEDMVG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 08:21:06 -0400
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       davidm@hpl.hp.com, bunk@fs.tum.de, eyal@eyal.emu.id.au,
       linux-dvb-maintainer@linuxtv.org, lkml <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>
In-Reply-To: <20040503215434.GI17014@parcelfarce.linux.theplanet.co.uk>
References: <20040501201342.GL2541@fs.tum.de>
	 <Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org>
	 <20040501161035.67205a1f.akpm@osdl.org>
	 <Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org>
	 <20040501175134.243b389c.akpm@osdl.org>
	 <16534.35355.671554.321611@napali.hpl.hp.com>
	 <Pine.LNX.4.58.0405031336470.1589@ppc970.osdl.org>
	 <20040503140251.274e1239.akpm@osdl.org>
	 <20040503211607.GG17014@parcelfarce.linux.theplanet.co.uk>
	 <20040503212450.GC31580@wohnheim.fh-wedel.de>
	 <20040503215434.GI17014@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1083672800.19086.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 04 May 2004 08:13:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-03 at 17:54, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> 	f) potentially racy flush_unauthorized_files() in selinux code - uses
> sys_close() in a strange way.

The SELinux flush_unauthorized_files code is based on flush_old_files in
fs/exec.c.  It is only executed upon a SID/context transition to flush
files that are not authorized for the new SID/context, and sharing of
the open file table across such transitions requires a share permission
that is only allowed where absolutely necessary, e.g. kernel->init.  Do
we need to change the code?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

