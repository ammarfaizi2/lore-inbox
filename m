Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbUJ0AIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbUJ0AIL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 20:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUJ0AIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 20:08:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:45983 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261603AbUJ0AIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 20:08:00 -0400
Date: Tue, 26 Oct 2004 17:11:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kim Holviala <kim@holviala.com>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [PATCH] mousedev: Fix scrollwheel thingy on IBM ScrollPoint
 mice
Message-Id: <20041026171157.21c7a15a.akpm@osdl.org>
In-Reply-To: <417E0EA8.7000704@holviala.com>
References: <417E0EA8.7000704@holviala.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kim Holviala <kim@holviala.com> wrote:
>
> The scrollwheel thingy (stick) on IBM ScrollPoint mice returns extremely
> aggressive values even when touched lightly. This confuses XFree which
> assumes the wheel values can only be 1 or -1. Incidently, it also
> confuses Windows' default mouse driver which proves the problem is in
> the mouse itself.
> 
> This patch limits the scroll wheel movements to be either +1 or -1 on
> the event -> emulated PS/2 level. I chose to implement it there because
> mousedev emulates Microsoft mice but the real ones almoust never return
> a bigger value than 1 (or -1).
> ...
> +#ifdef CONFIG_INPUT_MOUSEDEV_WHEELFIX
> +				if (value) { value = (value < 0 ? -1 : 1); }
> +#endif /* CONFIG_INPUT_MOUSEDEV_WHEELFIX */

This is really not a thing which we can put behind compile-time config.

Can we come up with a fix which works correctly on all hardware?  If not,
this workaround will need to be enabled by some sort of runtime detection.

