Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbTKBHZt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 02:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbTKBHZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 02:25:48 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:42500 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261522AbTKBHZr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 02:25:47 -0500
Date: Sun, 2 Nov 2003 08:25:19 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Geoffrey Lee <glee@gnupilgrims.org>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [patch] reproducible athlon mce fix
Message-ID: <20031102072519.GD530@alpha.home.local>
References: <20031102055748.GA1218@anakin.wychk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031102055748.GA1218@anakin.wychk.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't know if the patch is correct, but :

On Sun, Nov 02, 2003 at 01:57:48PM +0800, Geoffrey Lee wrote:
>  	preempt_disable(); 
> +#if CONFIG_MK7
> +	for (i=1; i<nr_mce_banks; i++) {
> +#else
>  	for (i=0; i<nr_mce_banks; i++) {
> +#endif

Including opening braces within #if often fools editors such as emacs
which count them and don't know about #if. Then, editing the rest of
the file can become annoying because it simply thinks that there are
two embedded for loops.

Other solutions to this problem often include one of these constructs
which are unfortunately not as beautiful :

1) a still readable one
#if CONFIG_MK7
	i=1;
#else
 	i=0;
#endif
 	for (; i<nr_mce_banks; i++) {

2) when there's absolutely no choice (eg changing part of an
   expression...) something unreadable like this.

	for (
#if CONFIG_MK7
	i=1;
#else
 	i=0;
#endif
 	i<nr_mce_banks; i++) {

I'm sure other people have other solution that don't come to mind.

Cheers,
Willy

