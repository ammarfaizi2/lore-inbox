Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265660AbUA0UUy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 15:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265662AbUA0UUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 15:20:54 -0500
Received: from moutng.kundenserver.de ([212.227.126.185]:11749 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265660AbUA0UUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 15:20:53 -0500
From: Christian Borntraeger <kernel@borntraeger.net>
To: joe.korty@ccur.com, dhowells@redhat.com, akpm@osdl.org
Subject: Re: [PATCH] volatile may be needed in rwsem
Date: Tue, 27 Jan 2004 21:20:42 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20040127191155.GA12128@tsunami.ccur.com>
In-Reply-To: <20040127191155.GA12128@tsunami.ccur.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401272120.42675.kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty wrote:
> 'flags' should be declared volatile as rwsem_down_failed_common() spins
> waiting for this to change.  Untested.


You should use barrier() to prevent the compiler from optimizing reads away, 
not volatile. 
Here the compiler hopefully considers schedule() as a memory barrier. So 
everything should be fine.

cheers

Christian

