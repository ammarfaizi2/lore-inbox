Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUANWHR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 17:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUANWHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 17:07:17 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:18736 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S263851AbUANWHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:07:12 -0500
Message-ID: <4005BD8D.4090806@samwel.tk>
Date: Wed, 14 Jan 2004 23:07:09 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=FCrgen_Scholz?= <juergen@scholz-gmbh.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hude read/write cache
References: <BC2B59C1.2E87%juergen@scholz-gmbh.cc>
In-Reply-To: <BC2B59C1.2E87%juergen@scholz-gmbh.cc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jürgen,

You could take a look at laptop-mode. This a patch that defers disk writes, so that your disks can 
remain spun down for longer than just a couple of seconds. I've actually done the port of this patch 
to Linux 2.6 because I wanted to achieve exactly what you want to achieve. Be aware though that most 
HDs have a VERY LIMITED amount of spinups/spindowns in them, about 50K for most desktop drives 
(which translates to about once every two hours over a 6-year lifetime). This is why I've actually 
abandoned my original goal -- I couldn't get my spindown frequency below about twice per hour, so 
that would kill my drives. If you care for your drives and your data, make ABSOLUTELY SURE that your 
drive doesn't spin up more than once every two hours on average. And if you can't make that happen, 
don't do it, find a quiet drive+case+fan+etc instead. Good luck!

-- Bart

Jürgen Scholz wrote:
> Hello!
> 
> I got a small server, which main purpose is routing and dialup besides being
> a repository for files. This system is very noisy. Because of that I want to
> stop the disks from spinning, when the system is in regular usage (standby,
> routing..). This should happen through a read and write cache which keeps
> the most often used files in RAM (like log files, bash, ...), so that there
> is no need for the system to access the (physical) hard drive.
> I would like to use a regular filesystem with a sort of transparent cache.
> Any ideas?
> 
> Ciao,
> Jürgen
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
