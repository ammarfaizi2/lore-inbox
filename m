Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVLGIRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVLGIRe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 03:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbVLGIRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 03:17:34 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:39430 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750713AbVLGIRd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 03:17:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vc6/DF+K3OSBhOGo+hI3qDQ/NNonMpkjrnUR9fYofncB80P0JUfri45Sk8l6znu7oLRueoXx5Ep4GY0ukF/khH1urJvk5aS/Kcjqj9pSJ2kZ021k9U//8gp7gBDTHxHVKJeVEug3bZl/B92fTTcWnm6PDpeHoGWi6eNwtuHzMzQ=
Message-ID: <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com>
Date: Wed, 7 Dec 2005 09:17:31 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Cc: Shaohua Li <shaohua.li@intel.com>, linux-ide <linux-ide@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>,
       Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>
In-Reply-To: <20051206222001.GA14171@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
	 <20051206222001.GA14171@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/05, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Tue, Dec 06, 2005 at 02:10:04PM +0800, Shaohua Li wrote:
>
> > TODO: invoking ATA commands.
> >
> > Though we didn't invoke ATA commands, this patch fixes the bug at
> > http://bugzilla.kernel.org/show_bug.cgi?id=5604. And Matthew said this
> > actually fixes a lot of systems in his test.
> > I'm not familiar with IDE, so comments/suggestions are welcome.
>
> Of the DSDTs I've looked at, most seem to provide taskfile commands
> concerned about doing things like setting up drive security. I haven't
> yet seen an IDE failure on resume when using this patch, so the _GTF
> stuff doesn't seem terribly important. The reason for it not currently
> being implemented is that the IDE queues haven't been restarted at the
> point where this code is called, so there's no obvious way of submitting
> them to the drive yet.

Isn't ide-io.c:ide_{start,complete}_power_step() enough?

BTW:

bugzilla bug #5604 - user is using 'ide-generic' host driver instead
of 'piix' so no wonder that suspend/resume doesn't work

bugzilla bug #2039 - is probably fixed by 2.6.12 (contains bugfix for
via82cxxx host driver not  bugfix for not restoring transfer mode)

"From Matthew Garrett  2005-03-30 17:17 UTC  [reply] -------

Linux currently has no real support for setting up IDE interfaces on resume.
Some machines are kind enough to set the IDE interface up themselves, but on
others we're doomed to failure. I'm looking into implementing this, but it won't
happen until some time after Hoary."

ide_{start,complete}_power_step() was there since the early 2.6.x days

Bartlomiej
