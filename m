Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUEXRP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUEXRP1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 13:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264385AbUEXRP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 13:15:27 -0400
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:46725 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S264382AbUEXRPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 13:15:10 -0400
Date: Mon, 24 May 2004 11:16:56 -0600
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: Tom Vier <tmv@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.6.6 IDE shutdown problems.
Message-ID: <20040524171656.GA19026@bounceswoosh.org>
Mail-Followup-To: Tom Vier <tmv@comcast.net>, linux-kernel@vger.kernel.org
References: <BAY18-F105X7rz6AvEm0002622f@hotmail.com> <200405151506.20765.bzolnier@elka.pw.edu.pl> <c8bdqv$lib$1@gatekeeper.tmr.com> <20040524024136.GB2502@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20040524024136.GB2502@zero>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23 at 22:41, Tom Vier wrote:
>On Mon, May 17, 2004 at 06:25:51PM -0400, Bill Davidsen wrote:
>> I would think that if the drive didn't properly flush cache on shutdown 
>> that it might cause corruption. Feel free to tell me no drive would 
>> bahave like that ;-)
>
>why not add a one or two second delay before? i doubt any drive holds its
>writeback that long.

That is an arbitrary delay that isn't guaranteed to work in all
workloads.

FLUSH CACHE is the way to do this, complain to vendors that don't
support flush cache and get them to fix their drives.  (Like how Bart
spoke to me and we both 1) worked out a solution for current drives
and 2) fixed the root case in all future firmwares)


Picture a nice fast drive doing 100 writes/second to the media... if
you give it over 200 writes at a time, it'll occupy your 2 seconds.
Newer drives with 8MB or larger buffers are certainly capable of
caching a lot more than 200 writes...

Drives are getting smarter so they can better work around these sorts
of cases, but FLUSH CACHE (EXT) is the only way that should be
guaranteed to work.

--eric


-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

