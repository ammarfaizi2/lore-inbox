Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWFFP7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWFFP7x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 11:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWFFP7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 11:59:53 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:33747 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751317AbWFFP7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 11:59:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pm9UNCEib04GNJkVZKH9xWHpydJzqV9q72t4OFZCQK4KFz3rW8R0t3SEmVTFHVThXWyyzs2ow42Or0ouGhiZTbsU6tJaVrj+y53n3YaoxvlAqGMv53fBfer7GPJPdY3FNrWlet+BkWeRsRc8W0NaQDBR31hPlXPlHpEJuxWv2Nk=
Message-ID: <b0943d9e0606060859q332bd90dpe7ad0996e370927b@mail.gmail.com>
Date: Tue, 6 Jun 2006 16:59:51 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 2.6.17-rc5 0/8] Kernel memory leak detector 0.5
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0606060850l4f8861b6je90e838b542b6fbc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060604215636.16277.15454.stgit@localhost.localdomain>
	 <6bffcb0e0606051452p26f20c8r57f2c782de691210@mail.gmail.com>
	 <b0943d9e0606060346sb42e00apbc194cee8db3986d@mail.gmail.com>
	 <6bffcb0e0606060850l4f8861b6je90e838b542b6fbc@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> I have disabled SMP and system still hangs, but now I know when :)
>
> Here is bug http://www.stardust.webpages.pl/files/kml/bug1.jpg

Yes, that's the deadlock I got as well. memleak_insert_aliases holds
the spinlock but it also calls kmalloc which calls the memleak_alloc
hook which deadlocks.

Hopefully, I fixed it know and tested it on ARM. I'll give it a try a
bit later on x86 and post a new patch.

Regards.

-- 
Catalin
