Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbVKMWL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVKMWL5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 17:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVKMWL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 17:11:57 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:49612 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750759AbVKMWL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 17:11:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VRmH9qLpIisSELWHIEVzPQQN8advCz2z1Ba3KX1KFARL4hp66AGowkkm3Aiih/RbrUzrTRUEZCD7NrvcjaI4qBdPD0yC8X0Qeu0GlZssouifRuUtl4eYtXYIn4mv5p/C30NZ816hK0KVeO6qTGNJmZ/hXZiQ+0rgM8j5ymG8zVk=
Message-ID: <4377BA19.2060600@gmail.com>
Date: Mon, 14 Nov 2005 06:11:37 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, Jason <dravet@hotmail.com>,
       Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
References: <58c2Z-8jG-23@gated-at.bofh.it> <E1EbNir-0006ky-DP@be1.lrz>
In-Reply-To: <E1EbNir-0006ky-DP@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:
> Antonino A. Daplas <adaplas@gmail.com> wrote:
> 
>> +++ b/drivers/video/console/vgacon.c
>> +#define VGA_FONTWIDTH       8   /* VGA does not support fontwidths != 8 */
> 
> This is not true, VGA cards do support fontwidth=9, but the ninth column

Yes.  What it should mean is that vgacon does not support fontwidths != 8.

> can only be blank or (optionally and only in the range of the IBM block
> chars) copied from the eighth column, cloning the behaviour of the MDA
> graphics card. If you disable this feature, you'll get 90x25 text resolution
> within standard VGA timings.
> 
> BTW while looking at this file:
> 
> 1) I see ORIG_VIDEO_EGA_BX (defined to (screen_info.orig_video_ega_bx)
> being checked to be 0x10, but I don't find a place where the associated
> variable is set to this value. Nor do I get the meaning of this variable
> by reading it's name.

Set at arch/i386/boot/video.S. It contains the contents of register bx
after calling int 0x10 ah=0x12 bl=0x10.

Tony
