Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbVLNSlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbVLNSlD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 13:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbVLNSlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 13:41:03 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:653 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S964867AbVLNSlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 13:41:01 -0500
Message-ID: <43A06771.6060808@t-online.de>
Date: Wed, 14 Dec 2005 19:41:53 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.7) Gecko/20050414
X-Accept-Language: de, en
MIME-Version: 1.0
To: "Antonino A. Daplas" <adaplas@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] Re: [PATCH 1/1: 2.6.15-rc5-git3] Fixed and
 updated CyblaFB
References: <439EF4CB.8030007@t-online.de> <43A03568.6010602@gmail.com>
In-Reply-To: <43A03568.6010602@gmail.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-ID: b0WLrGZDZeUt2gWpge1V2dZsLBuYQQ9qGI9Z1AfY423lF5OGGbbdUP@t-dialin.net
X-TOI-MSGID: 7ae12186-9f71-45b3-8242-411239c2d40a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino Daplas wrote:

>But current users of cyblafb will be affected if your patch
>does have a problem.
>
>  
>
They definitely will be affected when they lock their system
while trying rotation options ...

>>+    // That should never happen, but it would be fatal
>>    
>>
>
>It won't :-)
>
>  
>
The graphics engine would not react kindly, and it does not really hurt.

>>+    if (image->width == 0 || image->height == 0) {
>>+        output("imageblit: width/height 0 detected\n");
>>+        return;
>>+    }
>>+
>>+    if (bpp < 8 || bpp > 32 || bpp % 8 != 0 ||
>>+                   info->pixmap.scan_align > 4 ) {
>>    
>>
>Why this paranoid check?  The check_var() function already
>guaranteed that these conditions will not happen.
>
>  
>
Yes, I am a bit paranoid. That paranoia led to the discovery of some bugs
nobody knew or cared about. But you are right, this check might be a bit too
paranoid.

>Do you really have to support scan_align 1 and 2?  Why not just stick
>with scan_align of 4, the code is so much easier to understand? I can't
>find anything useful with this, even for debugging.
>
>  
>
Well, you are shure that there is really not a single bug left in the 
bitmap construction
code? And that the code will never be touched again because it already 
is optimal? I
think support for all alignment possibilities will be handy in the near 
future, and
although it could be hidden by an #ifdef or stay a private patch, I 
prefer to include it.

Currently bitmap construction takes longer than blitting the image to 
the screen with
cyblafb, and I think I will have a very close look at that code soon.

BTW, something fundamental: Isn´t the pixelmap alignment really a 
property of the
image bitmap like the depth of the image data?

>>+    // try to be smart about (x|y)res(_virtual) problems.
>>+    //
>>+    if (var->xres % 8 != 0)
>>        return -EINVAL;
>>    
>>
>
>Isn't this too much?  Why not var->xres = (var->xres + 7) & ~7?
>
>  
>
Do you really think that this is a good idea? I would like to ease the 
use of
e.g. fbset in scripts by returning -EINVAL when something as fundamental as
the selected xres is not acceptable. Ok, it´s always possible to parse 
the output
of fbset -s  in those cases.

>>+    if (var->xres_virtual % 8 != 0)
>>+        var->xres_virtual &= ~7;
>>    
>>
>
>Or just var->xres_virtual &= ~7 without the if (...)
>  
>
Yes. That saves a few bytes.

>Wrong boolean check?  Should be if (vesafb & 4). Or might as
>well get rid of this check, it's redundant.
>
>Shouldn't this be if (vesafb & 4)?
>  
>
>and this...
>
>  
>
>and this...?
>  
>
No, no, no, no.

cu,
 Knut
