Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130705AbRCEWJR>; Mon, 5 Mar 2001 17:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130707AbRCEWI6>; Mon, 5 Mar 2001 17:08:58 -0500
Received: from stm.lbl.gov ([131.243.16.51]:23826 "EHLO stm.lbl.gov")
	by vger.kernel.org with ESMTP id <S130706AbRCEWIx>;
	Mon, 5 Mar 2001 17:08:53 -0500
Date: Mon, 5 Mar 2001 14:08:18 -0800
From: David Schleef <ds@schleef.org>
To: Padraig Brady <Padraig@AnteFacto.com>
Cc: William Stearns <wstearns@pobox.com>,
        ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OFFTOPIC] Hardlink utility - reclaim drive space
Message-ID: <20010305140818.A31372@stm.lbl.gov>
Reply-To: David Schleef <ds@schleef.org>
In-Reply-To: <Pine.LNX.4.30.0102191626090.29121-100000@sparrow.websense.net> <3AA3E63E.80101@AnteFacto.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AA3E63E.80101@AnteFacto.com>; from Padraig@AnteFacto.com on Mon, Mar 05, 2001 at 07:17:18PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2001 at 07:17:18PM +0000, Padraig Brady wrote:
> Hmm.. useful until you actually want to modify a linked file,
> but then your modifying the file in all "merged" trees.

Use emacs, because you can configure it to do something
appropriate with linked files.  But for those of us addicted
to vi, the attached wrapper script is pretty cool, too.





dave...


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=cow-wrapper

#!/bin/bash
#
# copy-on-write wrapper for hard linked files
# Copyright 2000 David A. Schleef <ds@schleef.org>
#
# Please send me any improvments you make to this script.  I just
# wrote it as a quick and dirty hack.


linkedfiles=

for each in $*
do
	case $each in
	-*)
		# ignore
		;;
	*)
		if [ -f "$each" ];then
			nlinks=$(stat $each|grep Links|sed 's/.*Links: \(.*\)\{1\}/\1/')
			if [ $nlinks -gt 1 ];then
				#echo unlinking $each
				linkedfiles="$linkedfiles $each"
				mv $each $each.orig
				cp $each.orig $each
			fi
		fi
		;;
	esac
done

/usr/bin/vim $*

for each in $linkedfiles
do
	if cmp $each $each.orig &>/dev/null
	then
		#echo relinking $each
		rm $each
		mv $each.orig $each
	fi
done


--Q68bSM7Ycu6FN28Q--
