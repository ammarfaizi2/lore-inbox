Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264561AbUHCAHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbUHCAHB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264562AbUHCAHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:07:00 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:4040 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S264561AbUHCAGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:06:55 -0400
Date: Tue, 3 Aug 2004 01:06:44 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Dave Jones <davej@redhat.com>
Cc: Ian Romanick <idr@us.ibm.com>, Jon Smirl <jonsmirl@yahoo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>
Subject: Re: DRM code reorganization
In-Reply-To: <20040802185746.GA12724@redhat.com>
Message-ID: <Pine.LNX.4.58.0408030048330.27728@skynet>
References: <20040802155312.56128.qmail@web14923.mail.yahoo.com>
 <410E81C3.2070804@us.ibm.com> <20040802185746.GA12724@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> How does this differ from any other subsystem that supports
> cards with features that may not be present in another model ?
> Other subsystems have dealt with this problem without the need
> to introduce horrors like the abstractions in DRM.

The biggest issue I have with all the other subsystems that do this, is
the re-writing of basic driver code *for every driver*, everyone has a PCI
table, with a routine called my_driver_probe, and my_driver_init and
my_driver_exit and when you start a new driver you have to go all
cut-and-paste on its ass, someone changes and interface, you've got to go
change 20 files...

The DRM doesn't suffer from this, we've made huge changes to the DRM pci
probing code for *all* drivers (it's in the -mm tree if you want to look)
by changing one file, I'd hate to see similiar work being done to the fb
tree, you'd be cut-n-pasting and changing names of functions and it would
be horrible drudge work, the DRM isn't a maintainers paradise but if you
learn how it works it is an awful lot easier to maintain than similiar
subsystems...

> And among other horrors, crap like typedef's that magically change their
> type completely depending on which file they are #include'd into.
> Overuse of typedefs is one thing, but what goes on with stuff like
> DRIVER_BUF_PRIV_T is bordering on obscene.
>

this sort of stuff could probably be cleaned up, I'm not so sure this
re-org everyone is pushing for isn't going to lead to people wishing it
was the old way again :-)

> >From the view of many kernel developers, anything would be
> better than the trainwreck of wrappers/macros/preprocessor abuse
> that's there right now.  I'd put money on a lot more people being
> prepared to hack on DRM's kernel code if it were more readable.
>

If we start putting fb type functionality into it more people will start
coming towards it alright... it would be nice if it was a bit more
homely..

I'm sitting on the fence at the moment, as I'm not going to be able to
contribute the amount of time for a big re-write I'm willing to help out
with small changes and keep track of what patches go where....

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

