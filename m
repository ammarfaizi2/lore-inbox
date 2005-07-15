Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVGORTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVGORTj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 13:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVGORTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 13:19:39 -0400
Received: from mail.cipsoft.com ([62.146.47.42]:35812 "EHLO mail.cipsoft.com")
	by vger.kernel.org with ESMTP id S261918AbVGORTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 13:19:37 -0400
Message-ID: <42D7F026.90400@cipsoft.com>
Date: Fri, 15 Jul 2005 19:19:34 +0200
From: Thoralf Will <thoralf@cipsoft.com>
Organization: CipSoft GmbH
User-Agent: Mozilla Thunderbird 1.0.2-1.4.1.centos4 (X11/20050323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: pc_keyb: controller jammed (0xA7)
References: <mailman.1121358841.8002.linux-kernel2news@redhat.com> <20050714182101.640137d8.zaitcev@redhat.com>
In-Reply-To: <20050714182101.640137d8.zaitcev@redhat.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> On Thu, 14 Jul 2005 18:27:01 +0200, Thoralf Will <thoralf@cipsoft.com> wrote:
> 
> 
>>I didn't find any useful answer anywhere so far, hope it's ok to ask here.
>>I'm currently trying to get a 2.4.31 up and running on an IBM
>>BladeCenter HS20/8843. (base system is a stripped down RH9)
>>
>>When booting the kernel the console is spammmed with:
>>   pc_keyb: controller jammed (0xA7)
>>But it seems there are no further consequences and the keyboard is
>>working.
> 
> 
> I saw a patch for it by Brian Maly, and yes, it was for 2.4.x.
> Maybe he can send you a rediff against current Marcelo's tree.
> 
> However, is there a reason you're running 2.4.31 in Summer of 2005?
> Did you try 2.6, does that one do the same thing? It has a rather
> different infrastructure with the serio.
> 
> -- Pete
> 

Meanwhile I've found the source of the problem. A simple change in
drivers/char/pc_keyb.c
line 73 did the trick.
- #define kbd_controller_present()        1
+ #define kbd_controller_present()        0

The only backdraw I've noticed so far is the problem that the kernel
won't work on servers with a ps/2 keyboard controller anymore (of
course) properly. But that's a minor issue.

We are still running 2.4 kernels because our application is incompatible
with the new thread library. A migration is already planned but that
takes time, alot of. I don't expect a migration to take place before the
end of the year, maybe even later.

Thoralf
