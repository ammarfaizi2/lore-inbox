Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVC0TZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVC0TZn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 14:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVC0TZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 14:25:43 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:42292 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261466AbVC0TZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 14:25:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=FCFFf6wCmXHuMs+ZEy+D2BnezUOJ7P4lrbGdabSaJH27wWXTkYbP2Byan3ibiusC3S1iPwGiTnTe+7izU0dbruHQVvNV6d18KJ3NdAUWsrcCFs1/15z6IwjLRRryI9X4x9Q/ljaAcz7/bB+601I8NuQh1UcPRHAEQqUTElzichs=
Message-ID: <84144f0205032711257b5ca1e2@mail.gmail.com>
Date: Sun, 27 Mar 2005 22:25:37 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Dave Jones <davej@redhat.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       penberg@cs.helsinki.fi
Subject: Re: [PATCH] no need to check for NULL before calling kfree() -fs/ext2/
In-Reply-To: <20050327174026.GA708@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
	 <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
	 <1111825958.6293.28.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
	 <Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>
	 <1111881955.957.11.camel@mindpipe>
	 <Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>
	 <20050327065655.6474d5d6.pj@engr.sgi.com>
	 <Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>
	 <20050327174026.GA708@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Mar 2005 12:40:26 -0500, Dave Jones <davej@redhat.com> wrote:
> Am I the only person who is completely fascinated by the
> effort being spent here micro-optimising something thats
> almost never in a path that needs optimising ?
> I'd be amazed if any of this masturbation showed the tiniest
> blip on a real workload, or even on a benchmark other than
> one crafted specifically to test kfree in a loop.

Indeed. The NULL checks are redundant and thus need to go. If someone
can show a measurable performance regression in the kernel for a
realistic workload, kfree() can be turned into an inline function
which will take care of it. The microbenchmarks are fun but should not
stand in the way of merging the kfree() cleanups from Jesper and
others.

                        Pekka
