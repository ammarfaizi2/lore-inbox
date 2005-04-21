Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVDUDId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVDUDId (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 23:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVDUDId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 23:08:33 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:25275 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261199AbVDUDIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 23:08:30 -0400
Message-ID: <42671901.4000805@ammasso.com>
Date: Wed, 20 Apr 2005 22:07:45 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Troy Benjegerdes <hozer@hozed.org>
CC: Bernhard Fischer <blist@aon.at>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs
 implementation
References: <200544159.Ahk9l0puXy39U6u6@topspin.com> <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com> <4263DBBF.9040801@ammasso.com> <1113840973.6274.84.camel@laptopd505.fenrus.org> <4263DF70.2060702@ammasso.com> <1113853240.6274.99.camel@laptopd505.fenrus.org> <20050418200711.GI15688@aon.at> <20050421021713.GP999@kalmia.hozed.org>
In-Reply-To: <20050421021713.GP999@kalmia.hozed.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Troy Benjegerdes wrote:

> Someone (aka Tospin, infinicon, and Amasso) should probably post a patch
> adding '#define VM_REGISTERD 0x01000000', and some extensions to
> something like 'madvise' to set pages to be registered.
> 
> My preference is said patch will also allow a way for the kernel to
> reclaim registered memory from an application under memory pressure.

I don't know if VM_REGISTERED is a good idea or not, but it should be absolutely 
impossible for the kernel to reclaim "registered" (aka pinned) memory, no matter what. 
For RDMA services (such as Infiniband, iWARP, etc), it's normal for non-root processes to 
pin hundreds of megabytes of memory, and that memory better be locked to those physical 
pages until the application deregisters them.

If kernel really thinks it needs to unpin those pages, then at the very least it should 
kill the process, and the syslog better have a very clear message indicating why.  That 
way, the application doesn't continue thinking that everything's still going to work.  If 
those pages become unpinned, the applications are going to experience serious data corruption.
