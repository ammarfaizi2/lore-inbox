Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264231AbUGFRZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbUGFRZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 13:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264236AbUGFRZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 13:25:58 -0400
Received: from jupiter.loonybin.net ([208.248.0.98]:63757 "EHLO
	jupiter.loonybin.net") by vger.kernel.org with ESMTP
	id S264231AbUGFRZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 13:25:56 -0400
Date: Tue, 6 Jul 2004 12:25:40 -0500
From: Zinx Verituse <zinx@epicsol.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 8139too in 2.6.x tx timeout
Message-ID: <20040706172539.GA28965@bliss>
References: <20040626222304.GA31195@bliss> <87hdsoghdv.fsf@devron.myhome.or.jp> <20040704194009.GA2029@bliss> <873c4713fl.fsf@ibmpc.myhome.or.jp> <20040706053328.GA860@bliss> <20040706064725.GA11069@bliss> <87eknp5f3d.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eknp5f3d.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 12:29:26AM +0900, OGAWA Hirofumi wrote:
> Zinx Verituse <zinx@epicsol.org> writes:
> 
> > I have now discovered what causes the card to work on knoppix --
> > The probe during the loading of the OSS "cs46xx.o" driver.  This driver
> > doesn't work with my sound card (non-AC97 codec), and does not finish
> > loading, but apparently it does some magic that causes the rtl8139C NIC
> > I have to work :x
> 
> Oh, cs46xx.o seems to have a workaround or something for ThinkPad.
> The cs46xx.o calling the "clkrun_hack(card, 1)" before initialize.
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks!  This was it.  I have no idea where this hack belongs in the
kernel (or even if it does), so I've just made a quick&dirty userland
program to do it.  Maybe it'll be useful to others:
http://zinx.xmms.org/misc/tmp/8139too/thinkpad_clkrun_hack.c

-- 
Zinx Verituse                                    http://zinx.xmms.org/
