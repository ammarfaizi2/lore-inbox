Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267099AbSKPAiz>; Fri, 15 Nov 2002 19:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267159AbSKPAiz>; Fri, 15 Nov 2002 19:38:55 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:28049 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267099AbSKPAiy>; Fri, 15 Nov 2002 19:38:54 -0500
Date: Fri, 15 Nov 2002 16:47:23 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Paul Larson <plars@linuxtestproject.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: writing to sysfs appears to hang
Message-ID: <20021116004723.GB3153@beaverton.ibm.com>
Mail-Followup-To: Paul Larson <plars@linuxtestproject.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <1037401217.11295.145.camel@plars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037401217.11295.145.camel@plars>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson [plars@linuxtestproject.org] wrote:
> I've been playing with sysfs and notices something odd.  If I do this:
> echo 1 > /sys/devices/sys/name
> the process appears to be hung.  ^c won't return control to me.  If I
> log in on another console though, I can't find it running in the process
> list.  All I can do is kill the login process.  No kernel errors when I
> do this, just the hung terminal.
> 
> -Paul Larson

I repeated your example and in a quick look at the backtrace
the echo is in a loop calling down into sysfs_write_file/dev_attr_store.

I think the problem is that if a device does not have a attribute store
function the return value from dev_attr_store is incorrect.

-andmike
--
Michael Anderson
andmike@us.ibm.com

