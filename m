Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbUENStq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUENStq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 14:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbUENStp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 14:49:45 -0400
Received: from ns.clanhk.org ([69.93.101.154]:5004 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S262101AbUENStR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 14:49:17 -0400
Message-ID: <40A514BD.1050308@clanhk.org>
Date: Fri, 14 May 2004 13:49:33 -0500
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: drivers/video/riva/fbdev.c broken on x86_64
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following snippet is from drivers/video/riva/fbdev.c  I'm put arrows 
on the lines I think break cursor loading.  It does segfault, but boy 
does the cursor look weird.  The code in this function is so confusing, 
I have no idea what was going on or how to fix it:

/**
 * rivafb_load_cursor_image - load cursor image to hardware
 * @data: address to monochrome bitmap (1 = foreground color, 0 = 
background)
 * @par:  pointer to private data
 * @w:    width of cursor image in pixels
 * @h:    height of cursor image in scanlines
 * @bg:   background color (ARGB1555) - alpha bit determines opacity
 * @fg:   foreground color (ARGB1555)
 *
 * DESCRIPTiON:
 * Loads cursor image based on a monochrome source and mask bitmap.  The
 * image bits determines the color of the pixel, 0 for background, 1 for
 * foreground.  Only the affected region (as determined by @w and @h
 * parameters) will be updated.
 *
 * CALLED FROM:
 * rivafb_cursor()
 */
static void rivafb_load_cursor_image(struct riva_par *par, u8 *data,
                                     u8 *mask, u16 bg, u16 fg, u32 w, u32 h)
{
        int i, j, k = 0;
        u32 b, m, tmp;

        for (i = 0; i < h; i++) {
->             b = *((u32 *)data);
                b = (u32)((u32 *)b + 1);
->              m = *((u32 *)mask);
                m = (u32)((u32 *)m + 1);
                reverse_order(&b);


-ryan
