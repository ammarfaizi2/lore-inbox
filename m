Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965058AbWEKCb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbWEKCb2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 22:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbWEKCb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 22:31:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44237 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965058AbWEKCb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 22:31:27 -0400
Date: Wed, 10 May 2006 22:31:09 -0400
From: Dave Jones <davej@redhat.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: Greg KH <gregkh@suse.de>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, trenn@suse.de,
       thoenig@suse.de
Subject: Re: [RFC] [PATCH] Execute PCI quirks on resume from suspend-to-RAM
Message-ID: <20060511023109.GB11693@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
	Greg KH <gregkh@suse.de>, Pavel Machek <pavel@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	trenn@suse.de, thoenig@suse.de
References: <446139FF.205@gmx.net> <20060510093942.GA12259@elf.ucw.cz> <4461C0CA.8080803@gmx.net> <20060510205600.GB23446@suse.de> <44625CE9.2060204@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44625CE9.2060204@gmx.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 11:36:41PM +0200, Carl-Daniel Hailfinger wrote:
 > Greg KH wrote:
 > > On Wed, May 10, 2006 at 12:30:34PM +0200, Carl-Daniel Hailfinger wrote:
 > >> Thinking about it again, if we restored the full pci config space
 > >> on resume, this quirk handling would be completely unnecessary.
 > >> Any reasons why we don't do that?
 > > 
 > > We do do that.  Look at pci_restore_state().
 > > 
 > > Actually, look at it in the latest -mm tree, that version works better
 > > than mainline does right now :)
 > 
 > Sorry. Even the version in -mm does not restore all 256 bytes, so it
 > will not change anything.

You can't generically look at a PCI device past the first 32 bytes.
*anything* could be there, including registers which cause the machine
to lock up when they get read.

This is exactly the reason that lspci by default only shows 32 bytes,
and you need to be root to see past that limit.

 > So either we really restore the full config space (probably a good idea
 > by itself)

No, *really* *really* bad idea :)

		Dave

-- 
http://www.codemonkey.org.uk
