Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965224AbWEZAoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbWEZAoJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 20:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965225AbWEZAoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 20:44:09 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:54215 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965223AbWEZAoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 20:44:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SjLwoD+Wbp+3P65taOCABj8uoWG+hsFvL2KaTdaZQLmKMET3qzKa2MIxWGSLNhxTt0MYBCGJHSCpKrvgscpvNHHaeagvjwcxfCAGK8HtY1I8j0qEVr/GVvUUEQK08Ysc+wwXsZ97KHBfaUlzz5EXfq8ZZy3QwF2HIxSOFh/EIic=
Message-ID: <44764F4F.5000102@gmail.com>
Date: Fri, 26 May 2006 08:43:59 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: nick@linicks.net
CC: Antonio <tritemio@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: : unclean backward scrolling
References: <5486cca80605210638l2906112fv515df1bc390cff24@mail.gmail.com> <7c3341450605211155i3674a27bob6213b449e2d1a3a@mail.gmail.com>
In-Reply-To: <7c3341450605211155i3674a27bob6213b449e2d1a3a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Warne wrote:
> Hmmmph.
> 
> I get this problem, and always have, but I always put it down to my system.
> 
> I run Slackware 10, and this has always happened to me from 2.6.2
> upwards on CRT 1024x768 and later TFT 1280x1024 dvi.
> 
> I use[d] in lilo:
> 
> # VESA framebuffer console @ 1280x1024x?k
> vga=794
> # VESA framebuffer console @ 1024x768x64k
> #vga=791
> 
> So you are not alone.
> 
> Nick
> 
> On 21/05/06, Antonio <tritemio@gmail.com> wrote:
>> Hi,
>>
>> I'm using the radeonfb driver with a radeon 7000 with the frambuffer
>> at 1280x1024 on a i386 system, with a 2.6.16.17 kernel. At boot time,
>> if I stop the messages with CTRL+s and try look the previous messages
>> with CTRL+PagUp (backward scrolling) the screen become unreadable. In
>> fact some lengthier lines are not erased scrolling backward and some
>> random characters a overwritten instead. So it's very difficult to
>> read the messages.
>>
>> I don't have such problem with the frambuffer at 1024x768.
>>
>> All the previous kernels I've tried have this problem (at least up to
>> 2.6.15).
>>
>> If someone can look at this issue I can provide further information.
>>
>> Many Thanks.
>>
>> Cheers,
>>

Can you try this patch and let me know if this fixes the problem?

Tony

PATCH: Fix scrollback with logo issue immediately after boot.

From: David Hollister <david.hollister@amd.com>

After the system boots with the logo, if the first action is a
scrollback, the screen may become garbled.  This patch ensures
that the softback_curr value is updated along with softback_in
following the scrollback.

Signed-off-by: David Hollister <david.hollister@amd.com>
Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/video/console/fbcon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index ca02071..953eb8c 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -2631,7 +2631,7 @@ static int fbcon_scrolldelta(struct vc_d
 					scr_memcpyw((u16 *) q, (u16 *) p,
 						    vc->vc_size_row);
 				}
-				softback_in = p;
+				softback_in = softback_curr = p;
 				update_region(vc, vc->vc_origin,
 					      logo_lines * vc->vc_cols);
 			}

