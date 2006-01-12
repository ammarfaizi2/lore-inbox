Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWALDyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWALDyU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 22:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbWALDyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 22:54:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23503 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932679AbWALDyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 22:54:20 -0500
Date: Wed, 11 Jan 2006 19:53:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: mchehab@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, xslaby@fi.muni.cz, jirislaby@gmail.com,
       mchehab@infradead.org
Subject: Re: [PATCH 09/20] V4L/DVB (3344d) Stradis video little cleanup
Message-Id: <20060111195340.0b74967c.akpm@osdl.org>
In-Reply-To: <20060112025553.PS72536800009@infradead.org>
References: <20060112025516.PS38541900000@infradead.org>
	<20060112025553.PS72536800009@infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mchehab@infradead.org wrote:
>
>  +errosd:
>  +	vfree(saa->osdbuf);
>  +	saa->osdbuf = NULL;
>  +erraud:
>  +	vfree(saa->audbuf);
>  +	saa->audbuf = NULL;
>  +errvid:
>  +	vfree(saa->vidbuf);
>  +	saa->vidbuf = NULL;
>  +err:
>  +	return -ENOMEM;
>   }

vfree(NULL) is legal, so this could be:

error:
	vfree(saa->osdbuf);
	vfree(saa->audbuf);
	vfree(saa->vidbuf);
	saa->vidbuf = NULL;
	saa->osdbuf = NULL;
	saa->audbuf = NULL;

