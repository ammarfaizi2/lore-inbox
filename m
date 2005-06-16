Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVFPHvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVFPHvc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 03:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVFPHvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 03:51:32 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:21167 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261152AbVFPHv3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 03:51:29 -0400
Date: Thu, 16 Jun 2005 09:54:00 +0200
From: DervishD <lkml@dervishd.net>
To: guorke <gourke@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mabye simple,but i confused
Message-ID: <20050616075400.GB57@DervishD>
Mail-Followup-To: guorke <gourke@gmail.com>, linux-kernel@vger.kernel.org
References: <d73ab4d005061522254f2e5933@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d73ab4d005061522254f2e5933@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 * guorke <gourke@gmail.com> dixit:
> in understangding the linux kernel, the authors says 
> "..Moves itself from address 0x00007c00 to address 0x00090000.."
> 
> What i confused is why the Boot Loader do this, i asked google,but
> still no answe.
> who can make me understand it ?

    Well, let's start with the Master Boot Record. In PC's the BIOS
loads the MBR at address 0x7c00, but the MBR is responsible for
loading the OS bootsector, if any. And the bootsectors are written
assuming that they're loaded by a MBR or *by the BIOS itself* so the
address they assume is 0x7c00. But the MBR is already at that
address! What can it do? Well, it moves itself out of the place.

    The problem is that the kernel itself could be loaded directly by
the BIOS (a long time ago, it was possible to boot from a raw floppy
containing an image of the kernel), and the first sector would be
loaded at 0x7c00, so the bootsector, MBR, loader or whatever has to
move out of that address at the very beginning. Why the physical
address 0x00090000 was used? I don't know. Well, it's well at the top
of the 640k base memory and the segment starts with 1001 in binary,
which is a fancy number XDD

    Hope that helps.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
