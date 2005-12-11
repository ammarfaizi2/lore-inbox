Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbVLKVNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVLKVNH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 16:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVLKVNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 16:13:07 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:64143 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750788AbVLKVNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 16:13:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Zh9z80l0v5x0AGybOsaUB2sOHxdAYEb99r9JqfRmy4qyxa4+pRsbomrQV+NvwR/GBU93vkqZ8184lwawMvBsRFcI6LX+WmROmB/fGvGtdsy5PqtsbVkmAKV8B1V7+UUGSqRcluSYY73TGDjb5j84qCHRMhaw1b/33OoMIwJOYRY=
Message-ID: <439C965C.5030100@gmail.com>
Date: Mon, 12 Dec 2005 05:13:00 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix vesafb display panning regression
References: <20051211041308.7bb19454.akpm@osdl.org> <9a8748490512110808q2d485407o52da0d4777fbf38e@mail.gmail.com>
In-Reply-To: <9a8748490512110808q2d485407o52da0d4777fbf38e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix vesafb hang when scroll mode is REDRAW.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

Jesper Juhl wrote:
> On 12/11/05, Andrew Morton <akpm@osdl.org> wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm2/
>>
> When booting this kernel with  vga=791 like I normally do, the kernel
> hangs on boot. Booting with vga=normal works just fine.
> I don't have very much info since as soon as the videomode is switched
> I get a small rectangle of messed up colours in the top left corner of
> the screen (the rest is just black) and then it hangs - even the
> keyboard is dead, I have to powercycle the machine.
> Nothing makes it to the logs and I don't have a second machine atm to
> get logs via serial console or netconsole.
> I've got the vesafb driver build in, none of the other fb drivers.
> 

Sorry about that.  This particular hunk was missing in the 
vesafb_trim_pan_display.patch

Tony

 drivers/video/vesafb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/vesafb.c b/drivers/video/vesafb.c
index e6e56b8..8982e54 100644
--- a/drivers/video/vesafb.c
+++ b/drivers/video/vesafb.c
@@ -417,6 +417,9 @@ static int __init vesafb_probe(struct pl
 	info->flags = FBINFO_FLAG_DEFAULT |
 		(ypan) ? FBINFO_HWACCEL_YPAN : 0;
 
+	if (!ypan)
+		info->fbops->fb_pan_display = NULL;
+
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
 		err = -ENOMEM;
 		goto err;
