Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263894AbUCZAt4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263890AbUCZArG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:47:06 -0500
Received: from pop.gmx.de ([213.165.64.20]:447 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263876AbUCZAoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 19:44:18 -0500
X-Authenticated: #271361
Date: Fri, 26 Mar 2004 01:44:03 +0100
From: Edgar Toernig <froese@gmx.de>
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: davem@redhat.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH] Consolidate multiple implementations of jiffies-msecs
 conversions.
Message-Id: <20040326014403.39388cb8.froese@gmx.de>
In-Reply-To: <Pine.LNX.4.58.0403251142110.3037@localhost.localdomain>
References: <Pine.LNX.4.58.0403251142110.3037@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sridhar Samudrala wrote:
> 
> The following patch to 2.6.5-rc2 consolidates 6 different implementations
> of msecs to jiffies and 3 different implementation of jiffies to msecs.
> All of them now use the generic msecs_to_jiffies() and jiffies_to_msecs()
> that are added to include/linux/time.h
>[...]
> -#define MSECS(ms)  (((ms)*HZ/1000)+1)
> -return (((ms)*HZ+999)/1000);
> +return (msecs / 1000) * HZ + (msecs % 1000) * HZ / 1000;

Did you check that all users of the new version will work correctly
with your rounding?  Explicit round-up of delays is often required,
especially when talking to hardware...

Ciao, ET.
