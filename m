Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268404AbUI2Ngo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268404AbUI2Ngo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268372AbUI2Ngn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:36:43 -0400
Received: from shockwave.systems.pipex.net ([62.241.160.9]:15529 "EHLO
	shockwave.systems.pipex.net") by vger.kernel.org with ESMTP
	id S268448AbUI2Nf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:35:57 -0400
Message-ID: <415ABA34.9080608@tungstengraphics.com>
Date: Wed, 29 Sep 2004 14:35:48 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       Xserver development <xorg@freedesktop.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: New DRM driver model - gets rid of DRM() macros!
References: <9e4733910409280854651581e2@mail.gmail.com> <20040929133759.A11891@infradead.org> <415AB8B4.4090408@tungstengraphics.com> <20040929143129.A12651@infradead.org>
In-Reply-To: <20040929143129.A12651@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Wed, Sep 29, 2004 at 02:29:24PM +0100, Keith Whitwell wrote:
> 
>>Christoph Hellwig wrote:
>>
>>
>>> - drm_flush is a noop.  a NULL ->flush does the same thing, just easier
>>> - dito or ->poll
>>> - dito for ->read
>>
>>Pretty sure you couldn't get away with null for these in 2.4, at least.
> 
> 
> Umm, of course you could.  There's only a hanfull instance defining a
> ->flush at all.  Similarly all file_ops for regular files and many char
> devices don't have ->poll.  no ->read is pretty rare but 2.4 chæcks it
> aswell.

I tried it, led to crashes (panics, I guess) & the change had to be reverted. 
  On reverting the crashes stopped.  This was for poll and read:

revision 1.12
date: 2003-04-23 23:42:28 +0000;  author: keithw;  state: Exp;  lines: +13 -0
Install dummy/noop read & poll fops unless the driver has replacements.
----------------------------
revision 1.11
date: 2003-04-22 08:06:13 +0000;  author: keithw;  state: Exp;  lines: +0 -94
remove DRM read, poll and write_string


I didn't do any more investigation & the behaviour may well be different 
nowadays.

Keith
