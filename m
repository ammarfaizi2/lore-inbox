Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266369AbSKHQZe>; Fri, 8 Nov 2002 11:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266653AbSKHQZe>; Fri, 8 Nov 2002 11:25:34 -0500
Received: from [217.167.51.129] ([217.167.51.129]:7132 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S266369AbSKHQZd>;
	Fri, 8 Nov 2002 11:25:33 -0500
Subject: Re: Linux 2.4.20-rc1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2002-Q4@gmx.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <3DCBAC99.7010909@gmx.net>
References: <Pine.LNX.4.44L.0211061033410.27268-100000@freak.distro.conectiva>
	<3DCAAF2D.2040202@gmx.net>  <3DCBAC99.7010909@gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 08 Nov 2002 17:34:18 +0100
Message-Id: <1036773258.8907.90.camel@zion>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-08 at 13:22, Carl-Daniel Hailfinger wrote:

> I managed to trim down the offending patch further. Reverting the new 
> attached patch is enough to fix my problem. Can someone of the framebuffer 
> experts please comment on this one?

Ok, I'm the one to blame for that patch.

It was intended to fix some problems where the console subsystem
would call fbcon_blank after the fbdev HW was put to suspend, thus
crashing the system.

This should really be fixed in the low level fb drivers to ignore
blanking when they are asleep though. This is a kind of hack as 2.4
lacks a proper model for ordering power management requests

Marcelo, feel free to delete those 4 lines (but not the whole patch),
just the 4 lines in fbcon_blank, I'll make sure the various drivers
are made safe.

Ben.

