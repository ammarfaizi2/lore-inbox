Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbTESTeZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 15:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTESTeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 15:34:24 -0400
Received: from air-2.osdl.org ([65.172.181.6]:6808 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263169AbTESTeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 15:34:23 -0400
Date: Mon, 19 May 2003 12:47:12 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: torvalds@transmeta.com, reiserfs-dev@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove 'strchr' warning from reiserfs
Message-Id: <20030519124712.2c4b692d.shemminger@osdl.org>
In-Reply-To: <20030517191611.GA10417@mars.ravnborg.org>
References: <20030517191611.GA10417@mars.ravnborg.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 May 2003 21:16:11 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> Hi Linus, please apply - maintainer cc:ed for info.
> 
> Reiserfs emits a warning about strchr being defined but not
> used. I finally tracked down the reason for this.
> gcc - when seeing strstr(x, "%") recognized that the second parameter
> is a char, and therefore uses strchr instead of strstr.
> The workaround to avoid the warning is to replace the call
> to strstr with strchr - which is OK.
> 
> This hides the warning, and brings us down to 6 warnings for a
> make defconfig bzImage.
> 
> 	Sam

Good job finding this, several others have looked and never found what
was causing it.  Is this gcc behaviour documented anywhere?  What other
surprises are there?
