Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbUJZPyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbUJZPyw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 11:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbUJZPyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 11:54:52 -0400
Received: from fbxmetz.linbox.com ([81.56.128.63]:42760 "EHLO xiii.metz")
	by vger.kernel.org with ESMTP id S261235AbUJZPyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 11:54:50 -0400
Message-ID: <417E733C.2040204@linbox.com>
Date: Tue, 26 Oct 2004 17:54:36 +0200
From: Ludovic Drolez <ludovic.drolez@linbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 bug: linux logo not displayed in vga16fb (bug found)
References: <4178CB95.7000505@linbox.com>
In-Reply-To: <4178CB95.7000505@linbox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ludovic Drolez wrote:
> Hi !
> 
> I used to have a nice vga boot logo with my 2.6.7 kernel, but with the 
> 2.6.9, my
> boot logo has disappeared (same .config)...
> It seems to switch to VGA, and some space is reserved for the logo, but 
> it is not displayed.
> The logo appears with vesafb.

I made a few diffs between my old working 2.6.7 kernel and the 2.6.9 and found 
something interesting in fbmem.c:

---------------
@@ -723,7 +419,7 @@
         if (fb_logo.logo == NULL || info->state != FBINFO_STATE_RUNNING)
                 return 0;

-       image.depth = fb_logo.depth;
+       image.depth = 8;
         image.data = fb_logo.logo->data;

         if (fb_logo.needs_cmapreset)
---------------

So, on my 2.6.9, I replaced the '8' by 'fb_logo.depth' and now the logo is 
shown! (but the screen is still not cleared as before when the kernel boots).

Where's the QA guy ? I want to see him now ! ;-)

Cheers,

-- 
Ludovic DROLEZ                              Linbox / Free&ALter Soft
152 rue de Grigy - Technopole Metz 2000                   57070 METZ
tel : 03 87 50 87 90                            fax : 03 87 75 19 26
