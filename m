Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263565AbUEPLac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbUEPLac (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 07:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263557AbUEPLac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 07:30:32 -0400
Received: from [62.38.236.120] ([62.38.236.120]:31180 "EHLO pfn1.pefnos")
	by vger.kernel.org with ESMTP id S263574AbUEPLaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 07:30:30 -0400
From: "P. Christeas" <p_christ@hol.gr>
To: Jan De Luyck <lkml@kcore.org>
Subject: [2.6.6] Synaptics driver is 'jumpy'
Date: Sun, 16 May 2004 14:27:44 +0300
User-Agent: KMail/1.6.2
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405161427.44859.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello List,
> 
> Since installing 2.6.6 on my trusty laptop, I can't use the built-in 
synaptics
> touchpad anymore. The tracking is totally broken:
> 
> When you touch-drag on the touchpad, the mouse cursor will jump to where you
> stopped your action approx. 1/1.5 seconds _after_ your move. This makes 
using
> the touchpad virtually impossible.
> 
> This problem is not present under 2.6.5, which I'm running right now.
> Same .config.
> 
> Nothing seems to show up in the logs that could reflect any problem.
> 
> Any pointers?
> 
> Jan
> 

Under normal load this shouldn't happen. It could only have to do with 
interrupts from PS/2 port.
However, this shows the actual problem with using Synaptics' absolute mode. I 
vote against having this as the default setting.
In the absolute mode, the CPU must process the absolute movements of the 
finger in order to translate them to mouse movements. That means that, under 
some system load, the mouse will not respond smoothly any more. I wouldn't 
like to have increased priority or so just for the mouse.
In the relative mode, the touchpad processor calculates the movements and 
queues them as mouse events to the PS/2. This buffering provides smooth 
movement even under heavy CPU usage. The downside is that in relative mode, 
the touchpad has no adjustments (only default ones) and no extra features 
(Z-axis, scroll zones). It may even not have the middle button (which I'm 
missing most)
Perhaps we should ask Synaptics for a better relative mode. AFAIK the PIC 
processor inside the touchpad is not upgradeable, but future models could 
offer better code..

Try running the touchpad in relative mode, with 'options psmouse proto=exps' 
at /etc/modprobe.conf, which disables the Synaptics (i.e. absolute mode).

