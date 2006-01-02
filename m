Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWABVvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWABVvl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 16:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWABVvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 16:51:41 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:55966 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750757AbWABVvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 16:51:41 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>, mingo@elte.hu,
       tim@physik3.uni-rostock.de, torvalds@osdl.org, davej@redhat.com,
       linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Date: Tue, 03 Jan 2006 08:51:31 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <sq7jr1l1ffgdc5ra26ra6n2ota7osj9c2q@4ax.com>
References: <20051229224839.GA12247@elte.hu> <1135897092.2935.81.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de> <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de> <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu> <20060102134228.GC17398@stusta.de> <20060102102824.4c7ff9ad.akpm@osdl.org> <1136227746.2936.46.camel@laptopd505.fenrus.org>
In-Reply-To: <1136227746.2936.46.camel@laptopd505.fenrus.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Jan 2006 19:49:06 +0100, Arjan van de Ven <arjan@infradead.org> wrote:

>Maybe the right approach is to start rejecting in reviews new code that
>uses inline inappropriately. (where "inappropriate" sort of is "more
>than 3 lines of C unless there is some constant-optimizes-away trick")

Well, I can own up to half a dozen inlines in a .c file, CodingStyle 
suggests to convert macros to static inline, so I did:

/* adm9240 internally scales voltage measurements */
static const u16 nom_mv[] = { 2500, 2700, 3300, 5000, 12000, 2700 };

static inline unsigned int IN_FROM_REG(u8 reg, int n)
{
        return SCALE(reg, nom_mv[n], 192);
}

static inline u8 IN_TO_REG(unsigned long val, int n)
{
        return SENSORS_LIMIT(SCALE(val, 192, nom_mv[n]), 0, 255);
}

/* temperature range: -40..125, 127 disables temperature alarm */
static inline s8 TEMP_TO_REG(long val)
{
        return SENSORS_LIMIT(SCALE(val, 1, 1000), -40, 127);
}

Are these typical targets for non-inline? 

Thanks,
Grant.
