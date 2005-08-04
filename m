Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVHDFJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVHDFJO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 01:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVHDFJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 01:09:14 -0400
Received: from outmx024.isp.belgacom.be ([195.238.2.128]:45270 "EHLO
	outmx024.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261801AbVHDFJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 01:09:12 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Date: Thu, 4 Aug 2005 07:09:18 +0200
User-Agent: KMail/1.8.1
Cc: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com
References: <200508031559.24704.kernel@kolivas.org>
In-Reply-To: <200508031559.24704.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508040709.19426.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 August 2005 07:59, Con Kolivas wrote:
> This is the dynamic ticks patch for i386 as written by Tony Lindgen
> <tony@atomide.com> and Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>.
> Patch for 2.6.13-rc5

On a weird sidenote: my synaptics touchpad seems to not-like dyntick very much. 
When starting with a dyntick enabled kernel I get when psmouse.ko is loaded:

Aug  4 06:45:47 precious kernel: Synaptics claims to have extended capabilities, but I'm not able to read them.<3>Unable to initialize Synaptics hardware.
Aug  4 06:45:47 precious kernel: input: PS/2 Synaptics TouchPad on isa0060/serio1

subsequently, X fails to start too (touchpad is set as corepointer)

reloading the module right then and there solves the problem:

Aug  4 06:47:47 precious kernel: Synaptics Touchpad, model: 1, fw: 5.8, id: 0x9d48b1, caps: 0x904713/0x4006
Aug  4 06:47:47 precious kernel: input: SynPS/2 Synaptics TouchPad on isa0060/serio1

Also, booting the same (but non-patched) kernel gives me a clean boot:

Aug  4 06:56:42 precious kernel: Synaptics Touchpad, model: 1, fw: 5.8, id: 0x9d48b1, caps: 0x904713/0x4006
Aug  4 06:56:42 precious kernel: input: SynPS/2 Synaptics TouchPad on isa0060/serio1

This is constantly reproducable for me. I guess some timing issue somewhere?

Jan

-- 
A good name lost is seldom regained.  When character is gone,
all is gone, and one of the richest jewels of life is lost forever.
		-- J. Hawes
