Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbTKBJAd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 04:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbTKBJAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 04:00:33 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:31872
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261598AbTKBJAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 04:00:31 -0500
Date: Sun, 2 Nov 2003 03:59:46 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Willy Tarreau <willy@w.ods.org>
cc: Geoffrey Lee <glee@gnupilgrims.org>, linux-kernel@vger.kernel.org,
       davej@redhat.com
Subject: Re: [patch] reproducible athlon mce fix
In-Reply-To: <20031102072519.GD530@alpha.home.local>
Message-ID: <Pine.LNX.4.53.0311020358080.32567@montezuma.fsmlabs.com>
References: <20031102055748.GA1218@anakin.wychk.org> <20031102072519.GD530@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Nov 2003, Willy Tarreau wrote:

> 1) a still readable one
> #if CONFIG_MK7
> 	i=1;
> #else
>  	i=0;
> #endif
>  	for (; i<nr_mce_banks; i++) {
> 
> 2) when there's absolutely no choice (eg changing part of an
>    expression...) something unreadable like this.
> 
> 	for (
> #if CONFIG_MK7
> 	i=1;
> #else
>  	i=0;
> #endif
>  	i<nr_mce_banks; i++) {
> 
> I'm sure other people have other solution that don't come to mind.

Perhaps..

#ifdef CONFIG_MK7
#define MCE_BANK_START	1
#else
#define MCE_BANK_START	0
#endif

for (i = MCE_BANK_START; nr_mce_banks; i++)
