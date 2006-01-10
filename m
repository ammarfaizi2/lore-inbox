Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWAJJB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWAJJB5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 04:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWAJJB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 04:01:56 -0500
Received: from wireless-88.fi.muni.cz ([147.251.51.88]:63885 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S1751017AbWAJJBz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 04:01:55 -0500
Date: Tue, 10 Jan 2006 10:01:51 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: intelfb
Message-ID: <20060110090151.GH12559@mail.muni.cz>
References: <20060108234839.GF3001@mail.muni.cz> <20060108235753.GR3774@stusta.de> <43C1ACB4.4030704@gmail.com> <20060109002912.GS3774@stusta.de> <20060109101805.GK3001@mail.muni.cz> <43C30DEA.1050101@gmail.com> <20060110083533.GF12559@mail.muni.cz> <43C3759A.4030106@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43C3759A.4030106@gmail.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 04:51:38PM +0800, Antonino A. Daplas wrote:
> > calculate pixel mod clock is wrong for this chip. And also I have an idea how to
> > setup a graphic mode on local LCD (laptops).
> > 
> 
> Can you post your hack to this list?

Well, for LVDS (internal LCD) I found, that PLL pixel clock is fixed accross any
resloution. This means that black magick used for PLL clock is not needed,
driver just need to read initial value of PLL registers and keep it (for
suspend/resume). It works to set resolution 640x480 using BIOS and then to 
correct Pipes and Display planes to any resolution you want (usualy the 
resolution of LCD). I guess that resolution 640x480 can be programmed directly
without BIOS (but I need to check it).

Another discover is that 0x61204 & ~1 allows LVDS register to be changed (and
also it disables LVDS output (DPMS D3 on LVDS). 0x61204 | 1 enables it back.

-- 
Luká¹ Hejtmánek
