Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbUCOKRP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 05:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbUCOKRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 05:17:15 -0500
Received: from ns2.uk.superh.com ([193.128.105.170]:5289 "EHLO
	smtp.uk.superh.com") by vger.kernel.org with ESMTP id S262522AbUCOKRO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 05:17:14 -0500
Date: Mon, 15 Mar 2004 10:13:40 +0000
From: Richard Curnow <Richard.Curnow@superh.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040315101340.GE17627@malvern.uk.w2k.superh.com>
Mail-Followup-To: Horst von Brand <vonbrand@inf.utfsm.cl>,
	lkml <linux-kernel@vger.kernel.org>
References: <20040311141703.GE3053@luna.mooo.com> <200403140245.i2E2jKSx005375@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403140245.i2E2jKSx005375@eeyore.valparaiso.cl>
User-Agent: Mutt/1.5.6i
X-OriginalArrivalTime: 15 Mar 2004 10:18:33.0999 (UTC) FILETIME=[DF2E51F0:01C40A76]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Horst von Brand <vonbrand@inf.utfsm.cl> [2004-03-14]:
> Micha Feigin <michf@post.tau.ac.il> said:
> > Is it possible to find out what the kernel's notion of HZ is from user
> > space?
> 
> What for? It should be invisible to userspace...
> 

A related issue that's bugged me for a long time is lack of userspace
access to the quantity that's called 'freq_scale' in 2.4, where it's
(1<<SHIFT_HZ)/HZ for HZ!=100 and 128/128.125 for HZ==100.  (I haven't
started to reverse-engineer the equivalent value in 2.6, I took a quick
look once and concluded things had got a little more hairy.)

My interest is that I maintain (in spare-time) an NTP application called
chrony (http://chrony.sunsite.dk/), originally written to be good for
dial-up, i.e. NTP servers accessible for a short window once or twice a
day.  This app wants to tune the parameters it passes to adjtimex() to
take a best shot at keeping the system clock correct over the
potentially 'long' offline period.  To do this well, it has to
reverse-compensate for the freq_scale multiplier that the kernel will
apply to the frequency value passed to adjtimex().  Getting the right
value for this across different kernels has always been a fragile
exercise.

-- 
Richard \\\ SH-4/SH-5 Core & Debug Architect
Curnow  \\\         SuperH (UK) Ltd, Bristol
