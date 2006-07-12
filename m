Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWGLNTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWGLNTN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 09:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWGLNTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 09:19:13 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:46694 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750930AbWGLNTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 09:19:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GJK6j1QorACRxFjUHik0bnJ0w+OrmN1zU0EdnJCxEZXhbXhLh85Q/8M9+AiiSNbZY3k9BjP/oZQ1mr0vOZ10/Qu8J311cUgYe7qP5cLoIcgcPdCtW/FEOzSBIjOJM8cdA0ZctcTvTqXAnLoXFSqBnWdg8BH5Ob6uKeg9nCA/iM4=
Message-ID: <6bffcb0e0607120619p6837a64bice7808856f93b11b@mail.gmail.com>
Date: Wed, 12 Jul 2006 15:19:11 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0607111454l1f9919eahbb3b683492a651e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <b0943d9e0607110628w60a436f7t449714eb4a3200ca@mail.gmail.com>
	 <6bffcb0e0607110649s464840a9sf04c7537809436b1@mail.gmail.com>
	 <b0943d9e0607110702p60f5bf3fg910304bfe06ec168@mail.gmail.com>
	 <6bffcb0e0607110802w4f423854rb340227331084596@mail.gmail.com>
	 <b0943d9e0607110844m6278da6crdc03bccce420da1d@mail.gmail.com>
	 <6bffcb0e0607110902u4e24a4f2jc6acf2eb4c3bae93@mail.gmail.com>
	 <b0943d9e0607110931n4ce1c569x83aa134e2889926c@mail.gmail.com>
	 <6bffcb0e0607111000q228673a9kcbc6c91f76331885@mail.gmail.com>
	 <b0943d9e0607111454l1f9919eahbb3b683492a651e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> Michal,
>
> On 11/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > On 11/07/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > > It looks like there are some reports in __alloc_skb. Please try the
> > > attached patch.
> >
> > Here is the result
> > http://www.stardust.webpages.pl/files/o_bugs/kml/ml4.txt
>
> Some of the __alloc_skb disappeared but there are still a lot of
> context_struct_to_string (812). Could you let it running for a bit to
> get more reported leaks (few thousands) and send me the contents of
> the /proc/slabinfo file (together with the memleak file)? I want to
> make sure whether it is a kmemleak problem or not.

Here is a slabinfo from current 2.6.18-rc1-git4 and 2.6.18-rc1 +
kmemleak http://www.stardust.webpages.pl/files/o_bugs/kml/slab.txt

I haven't seen that before
orphan pointer 0xf1283e34 (size 224):
  c01735c2: <kmem_cache_alloc>
  fdc8c5cf: <ip_conntrack_alloc>
  fdc8c6a3: <init_conntrack>
  fdc8c894: <ip_conntrack_in>
  fdc8b652: <ip_conntrack_local>
  c02c15bf: <nf_iterate>
  c02c1630: <nf_hook_slow>
  c02e127e: <raw_send_hdrinc>

http://www.stardust.webpages.pl/files/o_bugs/kml/ml5.txt (4MB)

>
> Thanks.
>
> --
> Catalin
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
