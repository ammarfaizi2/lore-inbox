Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318876AbSH1P2e>; Wed, 28 Aug 2002 11:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318878AbSH1P2e>; Wed, 28 Aug 2002 11:28:34 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:31933 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318876AbSH1P2d>; Wed, 28 Aug 2002 11:28:33 -0400
Date: Wed, 28 Aug 2002 08:30:39 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG+FIX] 2.4 buggercache sucks
Message-ID: <238727922.1030523435@[10.10.2.3]>
In-Reply-To: <200208281128.28256.roy@karlsbakk.net>
References: <200208281128.28256.roy@karlsbakk.net>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew had a new version that he just submitted to 2.5,
but it may not backport easily.

The agreement at OLS was to treat read and write seperately - 
nuke them immediately for one side, and reclaim under mem
pressure for the other. Half of Andrea's patch, and half of 
Andrew's. Unfortunately I can never remember which was which ;-)
And I don't think anyone has rolled that together yet ....

Summary: the code below probably isn't the desired solution.

M.

--On Wednesday, August 28, 2002 11:28 AM +0200 Roy Sigurd Karlsbakk <roy@karlsbakk.net> wrote:

> hi
> 
> the patch below has now been tested out for quite some time.
> 
> Will it be likely to see this into 2.4.20?
> 
> roy
> 
> 
> On Friday 24 May 2002 21:32, Andrew Morton wrote:
>> "Martin J. Bligh" wrote:
>> > >> Sounds like exactly the same problem we were having. There are two
>> > >> approaches to solving this - Andrea has a patch that tries to free
>> > >> them under memory pressure, akpm has a patch that hacks them down as
>> > >> soon as you've fininshed with them (posted to lse-tech mailing list).
>> > >> Both approaches seemed to work for me, but the performance of the
>> > >> fixes still has to be established.
>> > > 
>> > > Where can I find the akpm patch?
>> > 
>> > http://marc.theaimsgroup.com/?l=lse-tech&m=102083525007877&w=2
>> > 
>> > > Any plans to merge this into the main kernel, giving a choice
>> > > (in config or /proc) to enable this?
>> > 
>> > I don't think Andrew is ready to submit this yet ... before anything
>> > gets merged back, it'd be very worthwhile testing the relative
>> > performance of both solutions ... the more testers we have the
>> > better ;-)
>> 
>> Cripes no.  It's pretty experimental.  Andrea spotted a bug, too.  Fixed
>> version is below.
>> 
>> It's possible that keeping the number of buffers as low as possible
>> will give improved performance over Andrea's approach because it
>> leaves more ZONE_NORMAL for other things.  It's also possible that
>> it'll give worse performance because more get_block's need to be
>> done for file overwriting.
>> 

