Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266755AbSKOVTD>; Fri, 15 Nov 2002 16:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266765AbSKOVTD>; Fri, 15 Nov 2002 16:19:03 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:65170 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266755AbSKOVTB>;
	Fri, 15 Nov 2002 16:19:01 -0500
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>, kniht@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-kernel-owner@vger.kernel.org, mailing-lists@digitaleric.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFDE7F70CA.ED358C3F-ON85256C72.00740082@pok.ibm.com>
From: "Khoa Huynh" <khoa@us.ibm.com>
Date: Fri, 15 Nov 2002 15:25:24 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 11/15/2002 04:25:26 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin wrote:
>I'm not sure we really want this to be 3-level as that'd involve
>replicating all the categories underneath. The OpSys field type
>suggestion as an independant field would be nice, but the Bugzilla
>code will need some tweaking to support possibly different default
>owners dependant on that field.
>
>For now, Jon has created us an "Alternate trees" category, with "ac"
>and "mm" components, with appropriate text in the template to encourage
>people to file bugs that happen (only) on those trees under the
>"tree-specific" categories, and we can move bugs out from there if
>need be. Hopefully that will make people happier for now, there may
>be a cleaner solution long-term, but that needs more thought and more
>work.

I think the problem with this scheme is that all of the components
in the -ac or -mm trees are slumped into a single component.

If we have to use a 2-level component list, then I'd prefer we
do the following:

Category = 2.5-linus, 2.5-ac, 2.5-mm, etc.
Component = something like
      MM-Page allocator
      MM-Slab allocator
      MM-NUMA
      MM-MTTR
      MM-Others
      FileSys-devfs
      FileSys-ext2
      FileSys-ext3
      and so on...

In other words, we just collapse the original category/component
list into a single level, and leave the top level to indicate which
trees.

Of course, only components belonging to a selected tree is displayed.
This would allow each tree to have its own set of components, which
can have different owners.

I have talked to Jon Tollefson and Jon agreed that this approach
is better.

We need to do it ASAP since the number of bugs (50+ currently) is
relatively small.  We do NOT want to wait until later to make
any structural changes to the component list because that would
be a nightmare to reclassify hundreds of bugs.

Another option would be to use the "group" concept in Bugzilla to
provide the 3-level component list structure that I described
previously, but this would require some coding changes.

The above approach does not require any coding changes in Bugzilla
and is therefore preferrable.

Khoa


