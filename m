Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269296AbTGQUIc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 16:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269219AbTGQUIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 16:08:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23967 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269296AbTGQUHv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 16:07:51 -0400
Message-ID: <3F170589.50005@pobox.com>
Date: Thu, 17 Jul 2003 16:22:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: schlicht@uni-mannheim.de, ricardo.b@zmail.pt, linux-kernel@vger.kernel.org
Subject: Re: SET_MODULE_OWNER
References: <1058446580.18647.11.camel@ezquiel.nara.homeip.net>	<3F16C190.3080205@pobox.com>	<200307171756.19826.schlicht@uni-mannheim.de>	<3F16C83A.2010303@pobox.com> <20030717125942.7fab1141.davem@redhat.com>
In-Reply-To: <20030717125942.7fab1141.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Thu, 17 Jul 2003 12:00:58 -0400
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> 
>>David?  Does Rusty have a plan here or something?
> 
> 
> It just works how it works and that's it.
> 
> Net devices are reference counted, anything more is superfluous.
> They may be yanked out of the kernel whenever you want.


(I'm obviously just realizing the implications of this... missed it 
completely during the earlier discussions)

Object lifetime is just part of the story.

This change is a major behavior change.  The whole point of removing a 
module is knowing its gone ;-)  And that is completely changed now. 
Modules are very often used by developers in a "modprobe ; test ; rmmod" 
cycle, and that's now impossible (you don't know when the net device, 
and thus your code, is really gone).  It's already breaking userland, 
which does sweeps for zero-refcount modules among other things.

I can't believe I missed this.

	Jeff



