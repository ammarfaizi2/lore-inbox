Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWEJVh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWEJVh5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 17:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWEJVh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 17:37:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:44960 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964998AbWEJVh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 17:37:56 -0400
X-Authenticated: #31060655
Message-ID: <44625CE9.2060204@gmx.net>
Date: Wed, 10 May 2006 23:36:41 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060316 SUSE/1.0-27 SeaMonkey/1.0
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, trenn@suse.de,
       thoenig@suse.de
Subject: Re: [RFC] [PATCH] Execute PCI quirks on resume from suspend-to-RAM
References: <446139FF.205@gmx.net> <20060510093942.GA12259@elf.ucw.cz> <4461C0CA.8080803@gmx.net> <20060510205600.GB23446@suse.de>
In-Reply-To: <20060510205600.GB23446@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, May 10, 2006 at 12:30:34PM +0200, Carl-Daniel Hailfinger wrote:
>> Thinking about it again, if we restored the full pci config space
>> on resume, this quirk handling would be completely unnecessary.
>> Any reasons why we don't do that?
> 
> We do do that.  Look at pci_restore_state().
> 
> Actually, look at it in the latest -mm tree, that version works better
> than mainline does right now :)

Sorry. Even the version in -mm does not restore all 256 bytes, so it
will not change anything. The quirk sits at offset 0xf2 in config space.
So either we really restore the full config space (probably a good idea
by itself) or we add the quirk handling to the suspend-to-ram codepath.

On a related note, what happens if we try to restore the config space of
a device which has vanished? Right now this happens on all mainboards
with asus_hides_smbus==1 during resume-from-ram.

Greg, do you have any comments on the patch starting this thread?

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
