Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270447AbTHLQDF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 12:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270479AbTHLQDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 12:03:05 -0400
Received: from fed1mtao03.cox.net ([68.6.19.242]:60033 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S270447AbTHLQDD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 12:03:03 -0400
Message-ID: <3F390FC4.9000300@cox.net>
Date: Tue, 12 Aug 2003 09:03:16 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] add an -Os config option
References: <20030811211145.GA569@fs.tum.de> <20030812080634.A19427@infradead.org> <3F390B36.5050709@techsource.com>
In-Reply-To: <3F390B36.5050709@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:

> Furthermore, it may be that we could benefit from compiling some source 
> files with -Os and others with -O2, depending on how critical they are 
> and how much they are ACTUALLY affected.
> 

At one time last year, there was a brief discussion about modifying 
the kernel's build process to make it build whole directories of 
sources as a single "compilation unit". As I remember, this allowed 
the compiler to make better decisions about how to organize the 
resulting code, what to keep/discard, optimization, etc.

With the simplifications that have already occurred in the 2.6 
makefiles, it seems to me that this would be an easier thing to do now 
(as opposed to the old makefiles where the build process had a harder 
time figuring out what source files were going to end up in the same 
object file). Now that kbuild always builds "built-on.o" in each 
source directory, could it perform that step by actually feeding gcc 
all the relevant source files in some combined form?

Granted, this is not something you'd want to use during debugging of 
kernel code, it would only be relevant for those trying to minimize 
their kernel size and/or get the last possible bits of speed out of 
the running kernel.

