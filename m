Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWAKV0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWAKV0D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWAKV0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:26:01 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:5071 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750729AbWAKV0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:26:01 -0500
Date: Wed, 11 Jan 2006 22:25:42 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, sct@redhat.com,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.15-git7 oopses in ext3 during LTP runs
In-Reply-To: <1137012917.2929.78.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0601112224280.7071@yvahk01.tjqt.qr>
References: <200601112126.59796.ak@suse.de>  <20060111124617.5e7e1eaa.akpm@osdl.org>
 <1137012917.2929.78.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>the conversion is buggy.
>
>mutex_trylock has the same convention as spin_try_lock (which is the
>opposite of down_trylock). THe conversion forgot to add a !
>
> static void ext3_write_super (struct super_block * sb)
> {
>-	if (mutex_trylock(&sb->s_lock) != 0)
>+	if (!mutex_trylock(&sb->s_lock) != 0)

How about a nicer...?

        if(mutex_trylock(&sb->s_lock) == 0)



Jan Engelhardt
-- 
