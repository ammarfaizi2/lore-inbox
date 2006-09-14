Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWINO6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWINO6t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWINO6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:58:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:38648 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750711AbWINO6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:58:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XjI8sdgdBQa7vMdIDlk1BW1+QhsZGOJ/J0sK5KhJiC9ysbP/TGrKZhrlX+W15r6Il2AG4/GREv5OV05u45KCpfKQUNkAb+fOkPOofP3rxLR4Tnxj52+WVTR81bDGofLMwVCEI7uxysYjUv3mp1psX0Bdki8XpYnYJMLCOhvnEN0=
Message-ID: <d120d5000609140758w7ba5cfdbs399d6831082e7cb4@mail.gmail.com>
Date: Thu, 14 Sep 2006 10:58:46 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Jiri Kosina" <jikos@jikos.cz>
Subject: Re: [PATCH 0/3] Synaptics - fix lockdep warnings
Cc: "Andrew Morton" <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Dave Jones" <davej@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0609141635040.2721@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz>
	 <200609132200.51342.dtor@insightbb.com>
	 <Pine.LNX.4.64.0609141028540.22181@twin.jikos.cz>
	 <d120d5000609140618h6e929883u2ed82d1cab677e57@mail.gmail.com>
	 <Pine.LNX.4.64.0609141635040.2721@twin.jikos.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/06, Jiri Kosina <jikos@jikos.cz> wrote:
> On Thu, 14 Sep 2006, Dmitry Torokhov wrote:
>
> > Can we add lock_class_key to the struct psmouse and use it to define
> > per-device mutex class regardless of whether it is a child, grandchild
> > or a parent?
>
> Hi Dmitry,
>
> what do you think about the patches below? I have used a slightly
> different approach, as we also need to get rid of the spurious lockdep
> warning in case of recursive call of serio_interrupt(), which can't be
> handled well with lock subclass stored in struct psmouse. What do you
> think about this? It shuts up the lockdep, and seems much cleaner to me.
>

Yes, this is much, much better. Could you please tell me if depth
should be a true depth or just an unique number? The reason I am
asking is that I hope to get rid of parent/child pointers in serio
(they were introduced when driver core could not handle recursive
addition/removing of devices on the same bus).

-- 
Dmitry
