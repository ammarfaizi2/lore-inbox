Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWA2U0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWA2U0r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 15:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWA2U0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 15:26:47 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:49548
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751163AbWA2U0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 15:26:47 -0500
Date: Sun, 29 Jan 2006 12:26:58 -0800
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does /sys/module/foo reflect external module name?
Message-ID: <20060129202658.GA7139@kroah.com>
References: <200601291914.48318.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601291914.48318.arvidjaar@mail.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 07:14:47PM +0300, Andrey Borzenkov wrote:
> Is it correct that /sys/module lists module *file* names (sans -_ confusion)? 
> Is it possible to find out if module is built in or truly external? The goal 
> is to automate initrd build by walking from /dev/root up and pulling in all 
> modules. Now missing module may mean that it is built in or that it is really 
> missing :) In my case:
> 
> {pts/1}% for i in /sys/module/*
> for> do
> for> grep -q ${i:t} /proc/modules || echo $i
> for> done
> /sys/module/8250
> /sys/module/i8042
> /sys/module/md_mod
> /sys/module/psmouse
> /sys/module/tcp_bic
> {pts/1}% for i in $(lsmod | awk '{print $1}')
> do
> [[ -d /sys/module/$i ]] || echo $i
> done
> Module
> 
> so it looks quite reliable up to built in modules. Is there any information 
> that could be exported in sysfs (like "builtin" == 0|1)?

What would that be needed for?  You can always just compare the list
with /proc/modules, right?

thanks,

greg k-h
