Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVEWF1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVEWF1s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 01:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVEWF1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 01:27:47 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:51036 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261849AbVEWF1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 01:27:43 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kris Karas <ktk@enterprise.bidmc.harvard.edu>
Subject: Re: Problem report: 2.6.12-rc4 ps2 keyboard being misdetected as /dev/input/mouse0
Date: Mon, 23 May 2005 00:27:36 -0500
User-Agent: KMail/1.8
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       Greg Stark <gsstark@mit.edu>
References: <87zmuveoty.fsf@stark.xeocode.com> <d120d500050518063926943e91@mail.gmail.com> <428BBEED.6090608@enterprise.bidmc.harvard.edu>
In-Reply-To: <428BBEED.6090608@enterprise.bidmc.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505230027.37308.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 May 2005 17:17, Kris Karas wrote:
> Dmitry Torokhov wrote:
> 
> >On 5/18/05, Pavel Machek <pavel@ucw.cz> wrote:
> >  
> >
> >>>Although... maybe the patch below is not too ugly.
> >>>      
> >>>
> >>Looks pretty much okay to me...
> >>    
> >>
> >
> >Does it work for you? If so I'll send it to Andrew to simmer in -mm.
> >  
> >
> 
> FWIW, I've tested the patch and it seems to be working just fine.  Thanks!
> 
> There is one exception, though it does not appear to be related to the 
> mouse code or the patch, as far as I can tell.   Pressing or releasing 
> the right-windows key sends a blank event to GPM (as reported by 'mev') 
> causing the mouse cursor to reappear.  If I use "showkey -s" to tell me 
> the scancode, nothing happens.  The key is evidently bound in the kernel 
> table, else I'd see the obligatory PRINTK encouraging me to bind it.  So 
> something is intercepting the key and sending it to GPM.   
> Experimentally, it appears as if the key press is delivered only if it 
> has not been pressed for roughly 3 seconds (256 Jiffies???).
> 

I wonder if the this patch from Vojtech will cure that problem...

-- 
Dmitry

===================================================================
From: Vojtech Pavlik <vojtech@suse.cz>

Input: Fix fast scrolling scancodes in atkbd.c

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
--

 atkbd.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: dtor/drivers/input/keyboard/atkbd.c
===================================================================
--- dtor.orig/drivers/input/keyboard/atkbd.c
+++ dtor/drivers/input/keyboard/atkbd.c
@@ -171,9 +171,9 @@ static struct {
 	unsigned char set2;
 } atkbd_scroll_keys[] = {
 	{ ATKBD_SCR_1,     0xc5 },
-	{ ATKBD_SCR_2,     0xa9 },
-	{ ATKBD_SCR_4,     0xb6 },
-	{ ATKBD_SCR_8,     0xa7 },
+	{ ATKBD_SCR_2,     0x9d },
+	{ ATKBD_SCR_4,     0xa4 },
+	{ ATKBD_SCR_8,     0x9b },
 	{ ATKBD_SCR_CLICK, 0xe0 },
 	{ ATKBD_SCR_LEFT,  0xcb },
 	{ ATKBD_SCR_RIGHT, 0xd2 },

