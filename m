Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbULQS5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbULQS5q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 13:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbULQS5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 13:57:46 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:14230 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262115AbULQS5o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 13:57:44 -0500
Date: Fri, 17 Dec 2004 19:54:03 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-ac16
Message-ID: <20041217185403.GA4454@electric-eye.fr.zoreil.com>
References: <1103222616.21920.12.camel@localhost.localdomain> <1103282619.4138.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103282619.4138.21.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> :
> On Thu, 2004-12-16 at 18:43 +0000, Alan Cox wrote:
> > o	Acenic must use __devinitdata for hotplug	(Alan Cox)
> > 	| based on an RH patch
[...]
>  MODULE_PARM_DESC(tx_ratio, "AceNIC/3C985/GA620 ratio of NIC memory used
> for TX/RX descriptors (range 0-63)");
> 
> 
> -static char version[] __initdata =
> +static char version[] __devinitdata =
>    "acenic.c: v0.92 08/05/2002  Jes Sorensen, linux-acenic@SunSITE.dk\n"
>    "http://home.cern.ch/~jes/gige/acenic.html\n";
> 
> you broke this one... :-)
> the version var *cannot* be initdata of any kind, since the ethtool
> ioctl uses the variable. End Of Story(tm)

Episode 2

Actually ethtool_drvinfo.get_drvinfo() does not use _this_ version var
in the acenic driver. Btw it would be waaaaay too long for the 32 bytes
allowed in the misc fields of struct ethtool_drvinfo) (I messed the
r8169 driver this way).

--
Ueimor
