Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWHVKBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWHVKBV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 06:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWHVKBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 06:01:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33944 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932091AbWHVKBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 06:01:20 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rohitseth@google.com, sekharan@us.ibm.com, Kirill Korotaev <dev@sw.ru>,
       Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1156240970.27114.5.camel@localhost.localdomain>
References: <44E33893.6020700@sw.ru>
	 <1155929992.26155.60.camel@linuxchandra>  <44E9B3F5.3010000@sw.ru>
	 <1156196721.6479.67.camel@linuxchandra>
	 <1156211128.11127.37.camel@galaxy.corp.google.com>
	 <1156240970.27114.5.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 22 Aug 2006 11:57:48 +0200
Message-Id: <1156240668.2976.35.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 11:02 +0100, Alan Cox wrote:
> Ar Llu, 2006-08-21 am 18:45 -0700, ysgrifennodd Rohit Seth:
> > I think as the tasks move around, it becomes very heavy to move all the
> > pages belonging to previous container to a new container.
> 
> Its not a meaningful thing to do. Remember an object may be passed
> around or shared. The simple "creator pays" model avoids all the heavy
> overheads while maintaining the constraints.

Hi,

there is one issue with the "creator pays" model: if the creator can
decide to die/go away/respawn then you can create orphan resources. This
is a leak at least, but if a malicious user can control the
death/respawn cycle it can even be abused to bypass the controls in the
first place. Keeping the owner alive until all shared users are gone is
not always a good idea either; if a container significantly malfunctions
(or requires a restart due to, say, a very urgent glibc security
update), keeping it around anyway is not a valid option for the admin.
(And it forms another opportunity for a malicious user, keep a
(vulnerable) container alive by hanging on to a shared resource
deliberately)

A general "unshare me out" function that finds a new to-blame owner
might work, just the decision whom to blame is not an easy one in that
scenario.
 
Greetings,
   Arjan van de Ven


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

