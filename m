Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbSJPOA5>; Wed, 16 Oct 2002 10:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262536AbSJPOA5>; Wed, 16 Oct 2002 10:00:57 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:56836 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262492AbSJPOA4>;
	Wed, 16 Oct 2002 10:00:56 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [4/7] oprofile - NMI hook 
In-reply-to: Your message of "Tue, 15 Oct 2002 23:33:19 +0100."
             <20021015223319.GD41906@compsoc.man.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 17 Oct 2002 00:06:40 +1000
Message-ID: <32233.1034777200@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002 23:33:19 +0100, 
John Levon <levon@movementarian.org> wrote:
>This patch provides a simple api to let oprofile hook into
>the NMI interrupt for the perfctr profiler.

Both kdb and lkcd use cross cpu NMI for debugging and dumping on SMP.
That plus oprofile and the NMI watchdog makes at least four users of
NMI.  A one level hook is not going to cut it, it should be a list.

I admit that removal of a hook from the NMI list while still handling
NMI interrupts is "interesting", but that is a SMOP ;).  RCU to the
rescue?

