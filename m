Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945950AbWANBaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945950AbWANBaE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 20:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423254AbWANBaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 20:30:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13711 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423253AbWANBaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 20:30:02 -0500
Date: Fri, 13 Jan 2006 17:31:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/17] fuse: add connection aborting
Message-Id: <20060113173158.7696130c.akpm@osdl.org>
In-Reply-To: <20060114004118.605226000@dorka.pomaz.szeredi.hu>
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
	<20060114004118.605226000@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
>  	unsigned mounted : 1;
>  	unsigned connected : 1;

Do these bitfields have locking?

On some architectures, it might be that

	foo->mounted = 1;

will race with another CPU doing

	bar->connected = 1;

if the CPU+compiler implements bitfield modification via non-atomic
read/modify/write.

I don't know whether that's happening in real life, but it's a subtle risk.
