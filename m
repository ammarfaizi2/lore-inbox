Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261393AbSITRV0>; Fri, 20 Sep 2002 13:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261653AbSITRV0>; Fri, 20 Sep 2002 13:21:26 -0400
Received: from p50887F27.dip.t-dialin.net ([80.136.127.39]:41911 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S261393AbSITRVZ>; Fri, 20 Sep 2002 13:21:25 -0400
Date: Fri, 20 Sep 2002 11:25:57 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Jean Tourrilhes <jt@bougret.hpl.hp.com>
cc: thunder@lightweight.ods.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FW: 2.5.34: IR __FUNCTION__ breakage
In-Reply-To: <20020920171314.GD8260@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0209201122450.342-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 20 Sep 2002, Jean Tourrilhes wrote:
> > Why not
> > 
> > #define DERROR(dbg, fmt, args...) \
> > 	do { if (DEBUG_##dbg) \
> > 		printk(KERN_INFO "irnet: %s(): " fmt, __FUNCTION, args); \
> > 	} while(0)
> > 
> > ?
> > 
> > 			Thunder
> 
> 	Try it, it won't work when there is zero args.

It got corrected shortly afterwards. The non-typo version is:

#define DERROR(dbg, fmt, args...) \
	do { if(DEBUG_##dbg) \
		printk(KERN_INFO "irnet: %s(): " fmt, __FUNCTION__, ##args); \
	} while(0)

Example:
#define DEBUG(fmt, args...) \
        printf("%s(): " fmt, __FUNCTION__, ## args)

int main(void)
{
        DEBUG("I am hungry.\n");

        exit(0);
}

# gcc -Wall -Os -o moehre -s moehre.c
# ./moehre
main(): I am hungry.
# 

			Thunder
-- 
assert(typeof((fool)->next) == typeof(fool));	/* wrong */

