Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbTEHRYj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 13:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbTEHRYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 13:24:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37388 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261888AbTEHRYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 13:24:38 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: The magical mystical changing ethernet interface order
Date: 8 May 2003 17:36:41 GMT
Organization: Transmeta Corp
Message-ID: <1052415401.563221@palladium.transmeta.com>
References: <20030507141458.B30005@flint.arm.linux.org.uk> <20030507150414.1eaeae75.akpm@digeo.com> <3EB98878.5060607@us.ibm.com> <1052395526.23259.0.camel@rth.ninka.net>
X-Trace: palladium.transmeta.com 1052415401 9984 127.0.0.1 (8 May 2003 17:36:41 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 8 May 2003 17:36:41 GMT
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: torvalds@penguin.transmeta.com (Linus Torvalds)
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1052395526.23259.0.camel@rth.ninka.net>,
David S. Miller <davem@redhat.com> wrote:
>On Wed, 2003-05-07 at 15:28, Dave Hansen wrote:
>> The linker will order things in the final object in the order that you
>> passed them.  We depend on this for getting __init functions run in the
>> right order:
>
>This is absolutely not guarenteed.  The linker is at liberty to
>reorder objects in any order it so desires, for performance reasons
>etc.
>
>Any reliance on link ordering is broken and needs to be fixed.

No. Last time this came up rth spoke up and said that link ordering _is_
guaranteed. 

The kernel depends on this in a lot more ways than just initcalls, btw:
all the exception handling etc also depend on the linker properly
preserving ordering of text/data sections.

If the linker ever starts re-orderign things, we'll just either not
upgrade to a broken linker, or we'll require a flag that disables the
re-ordering. 

End of discussion. 

			Linus
